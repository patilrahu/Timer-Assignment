import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer_app/constant/image_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/feature/login/ui/login.dart';
import 'package:timer_app/feature/login/view_model/login_view_model.dart';
import 'package:timer_app/feature/sign_up/view_model/sign_up_view_model.dart';
import 'package:timer_app/utils/toast_helper.dart';
import 'package:timer_app/widget/app_background.dart';
import 'package:timer_app/widget/app_button.dart';
import 'package:timer_app/widget/app_text.dart';
import 'package:timer_app/widget/app_text_field.dart';

class SignUp extends ConsumerWidget {
  SignUp({super.key});
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(ImageConstant.backButtonImage),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: AppText(
                      text: StringConstant.signUpText,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: AppTextfield(
                      onChanged: (value) =>
                          ref.read(userNameProvider.notifier).state = value,
                      controller: userNameController,
                      hintText: StringConstant.enterUserName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: AppTextfield(
                      onChanged: (value) =>
                          ref.read(signUpemailProvider.notifier).state = value,
                      controller: emailController,
                      hintText: StringConstant.enterEmail,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: AppTextfield(
                      onChanged: (value) =>
                          ref.read(signUppasswordProvider.notifier).state =
                              value,
                      controller: passwordController,
                      isObsecure: true,
                      hintText: StringConstant.enterPassword,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 15),
              child: Consumer(
                builder: (context, ref, child) {
                  var email = ref.watch(signUpemailProvider);
                  var password = ref.watch(signUppasswordProvider);
                  var userName = ref.watch(userNameProvider);
                  var signUp = ref.watch(signUpProvider);
                  return AppButton(
                    title: StringConstant.continueText,
                    isEnable: email != "" && password != "" && userName != "",
                    isLoading: signUp.isLoading,
                    onPressed: () async {
                      if (password.length < 6) {
                        ToastHelper.showErrorToast(
                          context,
                          'Password should be at least 6 characters long',
                        );
                        return;
                      }
                      await ref
                          .read(signUpProvider.notifier)
                          .signUpUser(
                            userNameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                      final updatedSignUpState = ref.read(signUpProvider);
                      if (updatedSignUpState.hasError) {
                        final error = updatedSignUpState.error;
                        _clearData(ref);
                        ToastHelper.showErrorToast(context, error.toString());
                        print("Sign up failed: $error");
                      } else if (updatedSignUpState.hasValue) {
                        _clearData(ref);

                        ToastHelper.showSuccessToast(
                          context,
                          StringConstant.signUpSuccess,
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Login();
                            },
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearData(WidgetRef ref) {
    ref.read(signUpemailProvider.notifier).state = '';
    ref.read(signUppasswordProvider.notifier).state = '';
    ref.read(userNameProvider.notifier).state = '';
    emailController.clear();
    userNameController.clear();
    passwordController.clear();
  }
}
