import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //get collection
  final CollectionReference notes =
      FirebaseFirestore.instance.collection("notes");
//create
  Future<void> addNote(String node) {
    return notes.add({'note': node, 'timestamp': Timestamp.now()});
  }

//read
  Stream<QuerySnapshot> getNotes() {
    final notesStrem = notes.orderBy('timestamp', descending: true).snapshots();
    return notesStrem;
  }

//update
  Future<void> updateNode(String docId, String newNode) {
    return notes
        .doc(docId)
        .update({'note': newNode, 'timestamp': Timestamp.now()});
  }

//delete
  Future<void> deleteNode(String docId) {
    return notes.doc(docId).delete();
  }
}
