import 'package:cloud_firestore/cloud_firestore.dart';

import '../state/firestore_item_list.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void listenToDocuments(String userId, Function(List<MyDocument>) callback) {
    _firestore.collection(userId).snapshots().listen((snapshot) {
      print('object length'+ snapshot.docChanges.length.toString());
      print('object'+ snapshot.docChanges.first.type.toString());
      final List<MyDocument> documents = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['doc_id'] = doc.id; // Add the document ID to the map
        return MyDocument.fromFirestore(data);
      }).toList();
      callback(documents);
    });
  }

  // Add a document to a Firestore collection
  Future<void> addDocument(
      String collectionName, Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).add(data);
  }

  // Update a document in a Firestore collection
  Future<void> updateDocument(String collectionName, String documentId,
      Map<String, dynamic> data) async {
    await _firestore.collection(collectionName).doc(documentId).update(data);
  }

  // Delete a document from a Firestore collection
  Future<void> deleteDocument(String collectionName, String documentId) async {
    await _firestore.collection(collectionName).doc(documentId).delete();
  }

  // Retrieve a list of documents from a Firestore collection
  Future<List<Map<String, dynamic>>> getDocuments(String collectionName) async {
    final QuerySnapshot snapshot =
        await _firestore.collection(collectionName).get();

    final List<Map<String, dynamic>> documents = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['doc_id'] = doc.id; // Add the document ID to the map
      return data;
    }).toList();
    return documents;
  }
  Future<List<MyDocument>> refreshData(String userId) async {
    var docs = await getDocuments(userId);
    List<MyDocument> myDocs = [];
    for (var element in docs) {
      print(element);
      MyDocument myDoc = MyDocument.fromFirestore(element);
      myDocs.add(myDoc);
    }
    return myDocs;
  }
}
