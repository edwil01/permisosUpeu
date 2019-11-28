import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO Ademas de todo el documento, tambien pasamos el ID del documento, que vendría a ser el UID del usuario
PersonaModel permisoModelFromSnap(DocumentSnapshot snap) => PersonaModel.fromJson(snap.data..addAll({'key': snap.documentID}),);

// String permisoModelToJson(PermisoModel data) => json.encode(data.toJson());

class PersonaModel {
    String key;
    String codigo;
    String nombre;
    String fotourl;
    String rol;

    PersonaModel({
        this.key,
        this.codigo,
        this.nombre,
        this.fotourl,
        this.rol,
    });

    factory PersonaModel.fromJson(Map<String, dynamic> json) => PersonaModel(
        key: json["key"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        fotourl: json["fotourl"],
        rol: json["rol"],
    );

    //TODO No vamos a crear usuario, solo son de lectura
    // Map<String, dynamic> toJson() => {
    //     "codigo": codigo,
    //     "nombre": nombre,
    //     "rol": rol,
    // };
}
