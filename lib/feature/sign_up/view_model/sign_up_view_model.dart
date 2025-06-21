import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/backend/firebase_auth_helper.dart';

final signUpemailProvider = StateProvider<String>((ref) => '');
final signUppasswordProvider = StateProvider<String>((ref) => '');
final userNameProvider = StateProvider<String>((ref) => '');
final signUpProvider =
    StateNotifierProvider<SignUpViewModel, AsyncValue<User?>>(
      (ref) => SignUpViewModel(),
    );

class SignUpViewModel extends StateNotifier<AsyncValue<User?>> {
  SignUpViewModel() : super(const AsyncValue.data(null));

  Future<void> signUpUser(
    String userName,
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      var userSignUpResponse = await FirebaseAuthHelper.signup(email, password);
      await userSignUpResponse.user?.updateDisplayName(userName);
      await userSignUpResponse.user?.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;
      state = AsyncValue.data(updatedUser);
    } on FirebaseAuthException catch (e) {
      state = AsyncValue.error(
        e.message ?? 'Sign Up failed',
        StackTrace.current,
      );
    } catch (e) {
      state = AsyncValue.error('Unexpected error: $e', StackTrace.current);
    }
  }
}
