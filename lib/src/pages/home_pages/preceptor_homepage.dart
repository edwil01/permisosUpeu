import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upeupermisos/src/blocs/authentication_bloc/bloc.dart';
import 'package:upeupermisos/src/pages/tabs/miperfil_tab.dart';
import 'package:upeupermisos/src/pages/tabs/nuevo_tab.dart';
import 'package:upeupermisos/src/pages/tabs/permisos_tab.dart';

class PreceptorHomepage extends StatefulWidget {
  const PreceptorHomepage({Key key}) : super(key: key);

  @override
  _PreceptorHomepageState createState() => _PreceptorHomepageState();
}

class _PreceptorHomepageState extends State<PreceptorHomepage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;

  List<Widget> _tabList = [
    PermisosTab(),
    MiPerfilTab(),
    NuevoTab(),
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
            title: Text("Nuevo"),
            icon: Icon(Icons.add_circle)
          )
        ],
      ),
    );
  }
}