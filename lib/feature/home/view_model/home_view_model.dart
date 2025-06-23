import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/backend/firebase_database.dart';
import 'package:timer_app/utils/shared_preference_helper.dart';

final nameProvider = FutureProvider<String>((ref) async {
  return await SharedPreferenceHelper.getValue(
        SharedPreferenceHelper.userName,
      ) ??
      '';
});
final breakEndedProvider = StateProvider<bool>((ref) => false);
final timeTickerProvider = StreamProvider<DateTime>((ref) {
  final breakEnded = ref.watch(breakEndedProvider);
  if (breakEnded) {
    return const Stream.empty();
  }
  return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
});

final breakData =
    StateNotifierProvider<HomeViewModel, AsyncValue<Map<String, dynamic>?>>(
      (ref) => HomeViewModel(),
    );

class HomeViewModel extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  HomeViewModel() : super(const AsyncValue.data(null));

  Future<void> fetchBreakData() async {
    try {
      state = AsyncValue.loading();
      var breakData = await FirebaseDatabaseHelper.fetchBreakData();
      state = AsyncValue.data(breakData);
    } catch (e) {
      state = AsyncValue.error('Unexpected error: $e', StackTrace.current);
    }
  }
}
