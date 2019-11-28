import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/permisos_bloc.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';
import 'package:upeupermisos/src/repository/permisos_repository.dart';
import '../detalle_page.dart';


class PermisosTab extends StatelessWidget {
  PermisosRepository _permRepository = PermisosRepository();

  PermisosTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermisosBloc, PermisosState>(
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
                      builder: (_) => DetallePage(permiso: perm, fab: _crearFabPreceptor(perm.idPermiso))
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
  Widget _crearFabPreceptor(String idPermiso) {
    return SpeedDial(
        backgroundColor: Colors.deepPurple,
        closeManually: false,
        child: Icon(Icons.account_box),
        overlayColor: Colors.deepPurple,
        overlayOpacity: 0.2,
        curve: Curves.easeIn,
        onOpen: () => print("Opening!"),
        onClose: () => print("Closing!"),
        children: [
          SpeedDialChild(
            child: Icon(Icons.delete_forever),
            label: "Denegar",
            backgroundColor: Colors.red,
            onTap: () {
              _permRepository.actualizarEstado(idPermiso, 'denegado');
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.verified_user),
            label: "Verificar",
            backgroundColor: Colors.grey,
            onTap: () => print("Second!"),
          ),
          SpeedDialChild(
            child: Icon(Icons.check),
            label: "Aprobar",
            backgroundColor: Colors.green,
            onTap: () {
              _permRepository.actualizarEstado(idPermiso, 'aprobado');
            },
          ),
        ],
      );
  }

  Widget _crearPermisoItem(PermisoModel per, { @required Function onTap }) {
    return ListTile(
      title: Text('${per.nombre}'),
      subtitle: Text('${per.codigo}'),
      trailing: _crearEstado(per.estado),
      onTap: onTap,
    );
  }

  Widget _crearEstado(String estado) {
    switch(estado) {
      case 'aprobado': return Icon(Icons.check_circle_outline, color: Colors.green,); break;
      case 'rechazado': return Icon(Icons.remove_circle_outline, color: Colors.red); break;
      case 'salida': return Icon(Icons.flight_takeoff, color: Colors.red); break;
      case 'entrda': return Icon(Icons.flight_land, color: Colors.red); break;
      default: return Icon(Icons.access_time); break;
    }
  }
}