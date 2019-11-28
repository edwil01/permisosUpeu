import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upeupermisos/src/blocs/authentication_bloc/bloc.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/mispermisos_bloc.dart';
import 'package:upeupermisos/src/blocs/permisos_blocs/permisos_bloc.dart';
import 'package:upeupermisos/src/pages/permiso_page.dart';
import 'package:upeupermisos/src/pages/home_pages/alumno_homepage.dart';

import 'package:upeupermisos/src/pages/home_pages/preceptor_homepage.dart';
import 'package:upeupermisos/src/pages/home_pages/seguridad_homepage.dart';

import 'package:upeupermisos/src/pages/login_page.dart';
import 'package:upeupermisos/src/repository/permisos_repository.dart';
import 'package:upeupermisos/src/repository/persona_repository.dart';
import 'package:upeupermisos/src/repository/user_repository.dart';

import 'package:upeupermisos/src/blocs/provider.dart';
//import 'package:app_resi/src/pages/permiso_page.dart';

// void main() => runApp(
//   BlocProvider(
//     builder: (context) => AuthenticationBloc(
//       userRepository: UserRepository(),
//       personaRepository: PersonaRepository()
//     )..add(AppStarted()),
//   child: MyApp(),
//   )
// );

void main() {
  // initializeDateFormatting('es_PE', null).then((_));
  return runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(
        userRepository: UserRepository(),
        personaRepository: PersonaRepository()
      )..add(AppStarted()),
    child: MyApp(),
    )
  );
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Provider(

    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Residencias UPeU',
        home: BlocListener<AuthenticationBloc,AuthenticationState>(
          listener: (context, state) {
            if(state is Authenticated) 
              Navigator.pushReplacementNamed(context, '${state.usuario.rol}Home');
            else
              Navigator.pushReplacementNamed(context, 'login');
          },
          child: Center( child: FlutterLogo(size: 100.0,), ), //TODO Acá puedes poner un CircularLoading
        ),
        routes: {          
          'login' : (BuildContext context) => LoginPage(),
          'alumnoHome': (context) => BlocProvider(
                                          builder: (context) => MisPermisosBloc( permisosRepository: PermisosRepository(), alumnoId: (BlocProvider.of<AuthenticationBloc>(context).state as Authenticated).usuario.key)..add(LoadPermisos()),
                                          child: AlumnoHomepage()),
          'preceptorHome': (context) => BlocProvider(
                                          builder: (context) => PermisosBloc(permisosRepository: PermisosRepository(), )..add(LoadPermisos()),
                                          child: PreceptorHomepage()),
          'seguridadHome': (context) => SeguridadHomepage(),
          'addPermiso': (context) => PermisoPage(),
          // 'tabs': (context) => TabsPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}