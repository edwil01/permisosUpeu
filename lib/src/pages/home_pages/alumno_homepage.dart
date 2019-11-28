import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upeupermisos/src/blocs/authentication_bloc/bloc.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/mispermisos_bloc.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';
import 'package:upeupermisos/src/pages/tabs/miperfil_tab.dart';
import 'package:upeupermisos/src/pages/tabs/mispermisos_tab.dart';

class AlumnoHomepage extends StatelessWidget {
  final List<Widget> containers = [
    MisPermisosTab(),
    MiPerfilTab(),
  ];

  AlumnoHomepage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: containers.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Residencias Upeu'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab( text: 'Notificaciones' ),
              Tab( text: 'Mi perfil' ),
            ],
          ),
          actions: <Widget>[
            IconButton( icon: Icon(Icons.search), onPressed: (){},),
            _crearPopupIcon(context),
          ],
        ),
        body: TabBarView(
          children: containers,
        ),
        floatingActionButton: _crearAddFAB(context),
      ),
    );
  }

  Widget _crearAddFAB(BuildContext context) {
    return FloatingActionButton(           
      child: Icon(Icons.add),
      onPressed: () {
        final onSave = (PermisoModel per) { BlocProvider.of<MisPermisosBloc>(context).add(AddPermiso(per)); };
        Navigator.of(context).pushNamed('addPermiso',arguments: onSave);
      },
    );
  }

  Widget _crearPopupIcon(BuildContext context) {
    return PopupMenuButton<int>( 
      onSelected: (index) { 
        if(index==0) { //TODO Salimos sesión
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          Navigator.pushReplacementNamed(context, 'login');
        }
      },             
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem(
          child: Text('Cerrar sesión'),
          value: 0,
        ),
      ],
    );
  }
}