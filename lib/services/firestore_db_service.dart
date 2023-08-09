import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_constants.dart';
import 'firebase_auth_service.dart';

class FirestoreDbService {
  FirestoreDbService._();

  static final instance = FirestoreDbService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _docPath;
  late String _colPath;

  set docPath(String value) => _docPath = value;
  set colPath(String value) => _colPath = value;

  Future<List> getDocs() async {
    final snapshot = await _firestore
        .collection(FirebaseConstants.topScores)
        .doc(_docPath)
        .collection(_colPath)
        .orderBy('score', descending: true)
        .get();
    return snapshot.docs;
  }

  Future<void> setData(Map<String, dynamic> data) async {
    await _firestore
        .collection(FirebaseConstants.topScores)
        .doc(_docPath)
        .collection(_colPath)
        .doc(FirebaseAuthService().user!.uid)
        .set(data);
  }
}
