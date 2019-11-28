import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:upeupermisos/src/pages/detalle_page.dart';
import 'package:upeupermisos/src/repository/permisos_repository.dart';

class ScanTab extends StatefulWidget {

  const ScanTab({Key key}) : super(key: key);
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanTab> {
  String barcode = "";
  PermisosRepository _permRepository;
  @override
  initState() {
    super.initState();
    _permRepository = PermisosRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: new AppBar(
        //   title: new Text('QR Code Scanner'),
        // ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('INICIAR ESCANEO')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,),
              )
              ,
            ],
          ),
        ));
  }

  Future scan() async {
    String barcode;
    try {
      barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = null;
        });
      } else {
        setState(() => this.barcode = null);
      }
    } on FormatException{
      setState(() => this.barcode = null);
    } catch (e) {
      setState(() => this.barcode = null);
    }
    if(barcode!=null) {
      final permiso = await _permRepository.obtenerPermiso(barcode);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => DetallePage(permiso: permiso, fab: _seguridadFab(permiso.idPermiso))
      ));
    }
  }

  Widget _seguridadFab(String idPermiso){
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
            label: "Confirmar Salida",
            backgroundColor: Colors.red,
            onTap: () {
              _permRepository.actualizarEstado(idPermiso, 'salida');
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.check),
            label: "Confirmar Entrada",
            backgroundColor: Colors.green,
            onTap: () {
              _permRepository.actualizarEstado(idPermiso, 'entrada');
            },
          ),
        ],
      );
  }


}