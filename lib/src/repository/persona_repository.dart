import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upeupermisos/src/models/persona_model.dart';

class PersonaRepository {
  final personaCollection = 
   Firestore.instance.collection('perm_persona');

  Future<PersonaModel> getPersonaById(String userId) {   
    return personaCollection.document(userId).get().then(
      (doc) => permisoModelFromSnap(doc)
    );
  }
}