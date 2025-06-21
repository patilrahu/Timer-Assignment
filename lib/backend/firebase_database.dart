import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabaseHelper {
  static const _dbName = 'users';
  static Future<void> storeQuestionAnswerData(
    Map<String, dynamic> answersData,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    await FirebaseFirestore.instance.collection(_dbName).doc(user.uid).set({
      'email': user.email,
      'displayName': user.displayName,
      'answers': answersData,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
