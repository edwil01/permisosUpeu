import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upeupermisos/src/blocs/authentication_bloc/bloc.dart';

class VerificaTab extends StatelessWidget {

  const VerificaTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated).usuario;
      
    return ListView(
      children: <Widget>[
        // Container(
        //   alignment: Alignment.center,
        //   padding: EdgeInsets.only(top: 40.0),
        //   child: CircleAvatar(
        //     radius: 45.0,
        //     backgroundImage: NetworkImage(currentUser.fotourl),
        //   ),
        // ),
        ListTile(
          title: Text(currentUser.nombre, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        ListTile(
          title: Text(currentUser.codigo),
          subtitle: Text('Wilson'),
        ),
        ListTile(
          title: Text(currentUser.rol),
          subtitle: Text('Mamani'),
        ),
      ],
    );
  }
}