import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upeupermisos/src/models/permiso_model.dart';

class PermisosRepository {
  final permisoCollection = 
   Firestore.instance.collection('perm_permiso');

  Future<void> addNewPermiso(PermisoModel permiso) {
    return permisoCollection.add(permiso.toJson());
  }

  Future<void> actualizarEstado(String idpermiso, String estado) {
    return permisoCollection.document(idpermiso)
      .updateData({ 'estado': estado });
  }

  Future<PermisoModel> obtenerPermiso(String idpermiso) {
    return permisoCollection.document(idpermiso)
      .get().then((doc) => PermisoModel.fromJson(doc));
  }

  Stream<List<PermisoModel>> getMisPermisos(String personaId) {   
    return permisoCollection.where('alumnoId', isEqualTo: personaId)
    .snapshots().map((snapshot) {
      return snapshot.documents
        .map((doc) => PermisoModel.fromJson(doc))
        .toList();
    });
  }

  Stream<List<PermisoModel>> getTodosPermisos() {
    return permisoCollection
      .snapshots().map((snapshot) {
      return snapshot.documents
      .map((doc) => PermisoModel.fromJson(doc))
      .toList();
    });
  }

  Stream<List<PermisoModel>> getTodasSolicitudes() {
    return permisoCollection.where('agruaproba',isEqualTo: false)
    .snapshots().map((snapshot) {
      return snapshot.documents
      .map((doc) => PermisoModel.fromJson(doc))
      .toList();
    });
  }
}