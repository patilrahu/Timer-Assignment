import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/backend/firebase_auth_helper.dart';

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<UserCredential?>>(
      (ref) => LoginViewModel(),
    );

class LoginViewModel extends StateNotifier<AsyncValue<UserCredential?>> {
  LoginViewModel() : super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      var userLoginResponse = await FirebaseAuthHelper.login(email, password);
      state = AsyncValue.data(userLoginResponse);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(
        e.message ?? 'Authentication failed',
        StackTrace.current,
      );
    } catch (e) {
      state = AsyncValue.error('Unexpected error: $e', StackTrace.current);
    }
  }
}
