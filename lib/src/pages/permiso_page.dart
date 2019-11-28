import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:upeupermisos/src/blocs/authentication_bloc/bloc.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';
import 'package:upeupermisos/src/utils/utils.dart';

typedef OnSaveCallback = Function(PermisoModel permiso);

class PermisoPage extends StatefulWidget {
  final _motivosList = ['Paseo','Viaje','Compras','Personales'];

  PermisoPage({Key key})
    : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<PermisoPage> {
  PermisoModel _permiso = new PermisoModel();
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fechsalida = new TextEditingController();
  TextEditingController _fechentrada = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final OnSaveCallback onSave = ModalRoute.of(context).settings.arguments;   

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Solicitud'),
        actions: <Widget>[
          FlatButton(
            child: Text('ENVIAR',
              style: TextStyle(color: Colors.white,),
            ),            
            onPressed: () { _onSubmit(onSave); },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _crearCampoMotivo(),
              _crearCampoFechas(),    
              _crearCampoApoderado(),      
              _crearCampoDescripcion(),              
            ],
          ),          
        ),
      ),
    );
  }

  void _mostrarSelectorFecha(Function(DateTime) onConfirm) {
    DatePicker.showDateTimePicker(context,
      minTime: DateTime(2019, 06, 1),
      maxTime: DateTime(2019, 12, 31),
      locale: LocaleType.es,
      onConfirm: onConfirm,       
    );
  }

  void _onSubmit(Function onSave) {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _completarPermiso(context); //TODO Completar los campos propios del alumno (CODIGO, NOMBRE, ID)
      onSave(_permiso); //TODO El Callback llama al Bloc para guardar finalmente el permiso
      Navigator.pop(context);
    }
  }

  void _completarPermiso(BuildContext context) {
    final currentUser = (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated).usuario;
    _permiso.codigo = currentUser.codigo;
    _permiso.nombre = currentUser.nombre;
    _permiso.alumnoId = currentUser.key;
  }

  Widget _crearCampoMotivo() {
    return DropdownButtonFormField(
      value: _permiso.motivo ,
      hint: Text('Motivo'),
      decoration: InputDecoration(
        icon: Icon(Icons.help_outline),
      ),
      items: widget._motivosList.map(
        (m) => DropdownMenuItem( child: Text(m), value: m )               
      ).toList(),
      onChanged: (value) {
        setState(() {
          _permiso.motivo = value;
        });
      },
      validator: (val) {
        return val==null ? 'Este campo es requerido.' : null;
      },
    );
  }

  Widget _crearCampoFechas() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.date_range)
        ),
        Flexible(
          child: TextFormField(
            controller: _fechsalida,
            decoration: InputDecoration(
              hintText: 'Fecha de salida',
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _mostrarSelectorFecha(
                (datetime) { 
                  setState(() {
                    _permiso.fechasalida = datetime;
                    _fechsalida.text = Format.toMonthDayDate(datetime);                              
                  });
                }
              );
            },
            validator: (val) {
              return val.trim().isEmpty ? 'Este campo es requerido.' : null;
            },
          ),
        ),
        SizedBox(width: 10.0,),
        Flexible(
          child: TextFormField(
            controller: _fechentrada,
            decoration: InputDecoration(
              hintText: 'Fecha de retorno',  
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              _mostrarSelectorFecha(
                (datetime) {
                  setState(() {
                    _permiso.fechaentrada = datetime;
                    _fechentrada.text = Format.toMonthDayDate(datetime);                             
                  });
                }
              );
            },
            validator: (val) {
              return val.trim().isEmpty ? 'Este campo es requerido.' : null;
            },
          )
        ),
      ],
    );
  }

  Widget _crearCampoApoderado() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.supervised_user_circle),
        hintText: 'Apoderado',
      ),
      validator: (val) {
        return val.trim().isEmpty ? 'Este campo es requerido.' : null;
      },
      onSaved: (value) {
        _permiso.apoderado = value;
      },
    );
  }

  Widget _crearCampoDescripcion() {
    return TextFormField(                
      maxLines: 5,
      decoration: InputDecoration(
        icon: Icon(Icons.message),
        hintText: 'Descripción',
      ),
      onSaved: (value) {
        _permiso.descripcion = value;
      },
    );
  }
}