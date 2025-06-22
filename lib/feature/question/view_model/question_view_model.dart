import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/backend/firebase_database.dart';
import 'package:timer_app/constant/string_constant.dart';

final progressProvider = StateProvider<double>((ref) => 0);
final answersProvider = StateProvider<Map<String, dynamic>>(
  (ref) => {
    StringConstant.questionText: null,
    StringConstant.doYouHavePhone: null,
    StringConstant.doYouUseGoogleMaps: null,
    StringConstant.dateOfBirth: null,
  },
);
final isLoadingProvider = StateProvider<bool>((ref) => false);
final questionViewModelProvider =
    StateNotifierProvider<QuestionViewModel, void>(
      (ref) => QuestionViewModel(),
    );

class QuestionViewModel extends StateNotifier<void> {
  QuestionViewModel() : super(null);

  Future<bool> saveDatainDatabase(
    Map<String, dynamic> data,
    WidgetRef ref,
  ) async {
    try {
      ref.read(isLoadingProvider.notifier).state = true;
      final now = DateTime.now();
      data['break_start_time'] = now.toIso8601String();
      data['break_duration_minutes'] = 30;
      await FirebaseDatabaseHelper.storeQuestionAnswerData(data);
      await Future.delayed(const Duration(seconds: 2));
      ref.read(isLoadingProvider.notifier).state = false;
      return true;
    } catch (e) {
      print(e);
      ref.read(isLoadingProvider.notifier).state = false;
      return false;
    }
  }

  void onAnswerChanged(WidgetRef ref, Map<String, dynamic> selectedAnswers) {
    final answered = selectedAnswers.entries.where((e) {
      final v = e.value;
      if (v == null) return false;
      if (v is String && v.trim().isNotEmpty) return true;
      if (v is List && v.isNotEmpty) return true;
      return false;
    }).length;
    final total = selectedAnswers.length;
    final progress = total > 0 ? answered / total : 0;
    ref.read(progressProvider.notifier).state = progress.toDouble();
  }
}
