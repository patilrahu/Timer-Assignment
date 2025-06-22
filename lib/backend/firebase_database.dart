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

  static Future<Map<String, dynamic>> fetchBreakData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    final doc = await FirebaseFirestore.instance
        .collection(_dbName)
        .doc(user.uid)
        .get();

    final data = doc.data();
    if (data == null || data['answers'] == null) {
      throw Exception("Answers not found for user");
    }

    final answers = data['answers'] as Map<String, dynamic>;

    final breakStart = DateTime.parse(answers['break_start_time']);
    final duration = answers['break_duration_minutes'];

    return {'start_time': breakStart, 'duration_minutes': duration};
  }

  static Future<void> endBreakNow() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    await FirebaseFirestore.instance.collection(_dbName).doc(user.uid).update({
      'answers.break_start_time': null,
      'answers.break_duration_minutes': null,
    });
  }
}
