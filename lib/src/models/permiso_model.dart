import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PermisoModel permisoModelFromJson(String str) => PermisoModel.fromJson(json.decode(str));

String permisoModelToJson(PermisoModel data) => json.encode(data.toJson());

class PermisoModel {
    String idPermiso;
    String alumnoId;
    String codigo;
    String nombre;
    String motivo;
    DateTime fechaentrada;
    DateTime fechasalida;
    String apoderado;
    String descripcion;
    String estado;
    // DateTime fsalida;
    // DateTime fentrada;

    PermisoModel({
        this.idPermiso,
        this.alumnoId,
        this.codigo,
        this.nombre,
        this.motivo,
        this.fechaentrada,
        this.fechasalida,
        this.apoderado,
        this.descripcion = '',
        this.estado = 'pendiente', //TODO Valor por default
        // this.fsalida,
        // this.fentrada,
    });

    factory PermisoModel.fromJson(DocumentSnapshot json) => PermisoModel(
        idPermiso: json.documentID,
        alumnoId: json.data["alumnoId"],
        codigo: json.data["codigo"],
        nombre: json.data["nombre"],
        motivo: json.data["motivo"],
        fechaentrada: (json.data["fechaentrada"] as Timestamp).toDate(),
        fechasalida: (json.data["fechasalida"] as Timestamp).toDate(),
        apoderado: json.data["apoderado"],
        descripcion: json.data["descripcion"],
        estado: json.data["estado"],
        // fsalida: (json.data["salida"] as Timestamp).toDate(),
        // fentrada: (json.data["entrada"] as Timestamp).toDate(),
    );

    


    Map<String, dynamic> toJson() => {
        
        "alumnoId": alumnoId,
        "codigo": codigo,
        "nombre": nombre,
        "motivo": motivo,
        "fechaentrada": Timestamp.fromDate(fechaentrada),
        "fechasalida": Timestamp.fromDate(fechasalida),
        "apoderado": apoderado,
        "descripcion": descripcion,
        "estado": estado,
        // "salida": Timestamp.fromDate(fsalida),
        // "entrada": Timestamp.fromDate(fentrada),
    };

}
