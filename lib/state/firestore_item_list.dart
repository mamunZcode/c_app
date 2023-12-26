import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../service/firestore_service.dart';

class MyItemList extends ChangeNotifier {
  List<MyDocument> _documents = [];

  List<MyDocument> get documents => _documents;

  // FirestoreService firestormService = FirestoreService();

  Future<String> loadData() async {
    return await rootBundle.loadString('assets/problems.json');
  }
  // void listenToDocuments(String userId) {
  //   firestoreService.listenToDocuments(userId, (documents) {
  //     _documents = documents;
  //     notifyListeners();
  //   });
  // }

  void updateDocuments(List<MyDocument> newDocuments) {
    _documents = newDocuments;
    notifyListeners(); // Notify listeners about the change
  }

  void deleteDocument(MyDocument document, String uid) async {
    var firestoreService = FirestoreService();
    await firestoreService.deleteDocument(uid, document.doc_id);
  }

  void removeAllData() {
    _documents.clear();
    notifyListeners();
  }
}

class MyDocument {
  final String id;
  final String doc_id;
  final String name;
  final String? role;

  const MyDocument({required this.id, required this.doc_id, required this.name, required this.role});

  factory MyDocument.fromFirestore(Map<String, dynamic> data) {
    return MyDocument(
      id: data['id'] as String,
      doc_id: data['doc_id'] as String,
      name: data['name'] as String,
      role: data['role'] as String?,
    );
  }
}
