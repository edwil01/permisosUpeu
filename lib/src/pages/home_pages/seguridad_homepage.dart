import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upeupermisos/src/blocs/authentication_bloc/bloc.dart';
import 'package:upeupermisos/src/pages/tabs/miperfil_tab.dart';
import 'package:upeupermisos/src/pages/tabs/nuevo_tab.dart';
import 'package:upeupermisos/src/pages/tabs/permisos_tab.dart';
import 'package:upeupermisos/src/pages/tabs/scan_tab.dart';

class SeguridadHomepage extends StatefulWidget {
  const SeguridadHomepage({Key key}) : super(key: key);

  @override
  _SeguridadHomepageState createState() => _SeguridadHomepageState();
}

class _SeguridadHomepageState extends State<SeguridadHomepage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;

  List<Widget> _tabList = [
    // PermisosTab(),
    Center(
      child: Text('AQUI VAN LOS PERMISOS APROBADOS')
    ),
    MiPerfilTab(),
    ScanTab(),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Residencias Upeu'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (currentIndex){
          // if(currentIndex==2) {
          //   //TODO Lanzar camara
          //   print('Scanear QR');
          //   return;
          // }
          setState(() { _currentIndex = currentIndex; });
          _tabController.animateTo(_currentIndex);
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Notificaciones"),
            icon: Icon(Icons.notifications_active)
          ),
          BottomNavigationBarItem(
            title: Text("Mi perfil"),
            icon: Icon(Icons.person)
          ),
          BottomNavigationBarItem(
            title: Text("Scanear"),
            icon: Icon(Icons.filter_center_focus)
          )
        ],
      ),
    );
  }
}