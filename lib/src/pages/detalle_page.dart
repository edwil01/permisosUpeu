
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';
import 'package:upeupermisos/src/utils/utils.dart';

class DetallePage extends StatelessWidget {
  final _estado = const ['Autorización','Control de Salida','Control de Entrada'];
  final _fab;
  final PermisoModel _permiso;

  const DetallePage({Key key, @required PermisoModel permiso, @required SpeedDial fab}) :
    _permiso = permiso,
    _fab = fab,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle'),
      ),
      body: ListView(
        children: _crearDetails(),
      ),
      // floatingActionButton: _crearAprobar(context),
      floatingActionButton: _fab,
     
    );
  }

  List<Widget> _crearDetails() {
    final List<Widget> props = 
    [
      _fab==null ? Center(
        child: QrImage(
          data: '${_permiso.idPermiso}',
          version: QrVersions.auto,
          size: 180,
          gapless: false,

        ),
      ) : Container(),
      ListTile(
        title: Text('ESTADO'),
        subtitle: Text(_permiso.estado),
      ),
      ListTile(
        title: Text('Motivo'),
        subtitle: Text(_permiso.motivo),
      ),
      ListTile(
        title: Text('Fecha de salida'),
        subtitle: Text(_permiso.fechasalida.toString()),
      ),
      ListTile(
        title: Text('Fecha de entrada'),
        subtitle: Text(_permiso.fechaentrada.toString()),
      ),
      ListTile(
        title: Text('Descripcion'),
        subtitle: Text(_permiso.descripcion.isEmpty?'(Vacío)':_permiso.descripcion),
      ),
       ListTile(
        title: Text('Apoderado'),
        subtitle: Text(_permiso.apoderado.isEmpty?'(Vacío)':_permiso.apoderado),
      ),       
    ];

    return props;
  }
  // Widget _crearAprobar(BuildContext context) {
  //   return FloatingActionButton(           
  //     child: Icon(Icons.check),
  //     onPressed: () {
  //       // final onSave = (PermisoModel per) { BlocProvider.of<MisPermisosBloc>(context).add(AddPermiso(per)); };
  //       // Navigator.of(context).pushNamed('addPermiso',arguments: onSave);
  //     },
  //   );
  // } 
}