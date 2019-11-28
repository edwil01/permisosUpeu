import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/mispermisos_bloc.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';
import 'package:upeupermisos/src/utils/utils.dart';
import '../detalle_page.dart';



class MisPermisosTab extends StatelessWidget {
  // final String _codigo;

  const MisPermisosTab({Key key}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MisPermisosBloc, PermisosState>(
      builder: (context, state) {
        if(state is PermisosLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if(state is PermisosLoaded) {
          final permisos = state.permisos;
          return ListView.builder(
            itemCount: permisos.length,
            // separatorBuilder: (context, index) => Divider(height: 1,),
            itemBuilder: (context, index) {
              final perm = permisos[index];
                return _crearPermisoItem( perm, onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetallePage(permiso: perm, fab: null)
                    ) 
                  );
                });
            },
          );
        } else {
          return Container();
        }
      },
    );    
  }  

  Widget _crearPermisoItem(PermisoModel per, { @required Function onTap }) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(Format.toMonthDayDate(per.fechasalida)),
          Text(Format.toMonthDayDate(per.fechaentrada)),
        ],
      ),
      title: Text('${per.motivo}'),
      subtitle: Text('${per.codigo}'),
      trailing: _crearEstado(per.estado),
      onTap: onTap,
    );
  }

  Widget _crearEstado(String estado) {
    switch(estado) {
      case 'aprobado': return Icon(Icons.check_circle_outline, color: Colors.green,); break;
      case 'denegado': return Icon(Icons.remove_circle_outline, color: Colors.red); break;
      case 'salida': return Icon(Icons.flight_takeoff, color: Colors.red); break;
      case 'entrada': return Icon(Icons.flight_land, color: Colors.red); break;
      default: return Icon(Icons.access_time); break;
    }
  }
}