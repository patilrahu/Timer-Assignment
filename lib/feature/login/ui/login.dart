import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/feature/login/view_model/login_view_model.dart';
import 'package:timer_app/feature/question/ui/questions.dart';
import 'package:timer_app/feature/sign_up/ui/sign_up.dart';
import 'package:timer_app/utils/shared_preference_helper.dart';
import 'package:timer_app/utils/toast_helper.dart';
import 'package:timer_app/widget/app_background.dart';
import 'package:timer_app/widget/app_button.dart';
import 'package:timer_app/widget/app_checkBox.dart';
import 'package:timer_app/widget/app_text.dart';
import 'package:timer_app/widget/app_text_field.dart';

class Login extends ConsumerWidget {
  Login({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 74),
                    child: AppText(
                      text: StringConstant.loginHeading,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: AppTextfield(
                      onChanged: (value) =>
                          ref.read(emailProvider.notifier).state = value,
                      controller: emailController,
                      hintText: StringConstant.enterUserName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: AppTextfield(
                      onChanged: (value) =>
                          ref.read(passwordProvider.notifier).state = value,
                      controller: passwordController,
                      isObsecure: true,
                      hintText: StringConstant.enterPassword,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: HexColor(ColorConstant.privacyPolicyColor),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          const TextSpan(text: StringConstant.dontHaveAccount),
                          TextSpan(
                            text: StringConstant.signUpText,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SignUp();
                                    },
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      spacing: 8,
                      children: [
                        AppCheckbox(onPressed: (selected) {}),
                        AppText(
                          text: StringConstant.iHaveReferalCode,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: HexColor(ColorConstant.privacyPolicyColor),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      const TextSpan(text: StringConstant.byClickingText),
                      TextSpan(
                        text: StringConstant.termsOfUseText,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(text: ' & '),
                      TextSpan(
                        text: StringConstant.privacyPolicyText,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 15),
                  child: Consumer(
                    builder: (context, ref, child) {
                      var email = ref.watch(emailProvider);
                      var password = ref.watch(passwordProvider);
                      var login = ref.watch(loginViewModelProvider);
                      return AppButton(
                        title: StringConstant.continueText,
                        isEnable: email != "" && password != "",
                        isLoading: login.isLoading,
                        onPressed: () async {
                          await ref
                              .read(loginViewModelProvider.notifier)
                              .login(
                                emailController.text,
                                passwordController.text,
                              );
                          final updatedLoginState = ref.read(
                            loginViewModelProvider,
                          );

                          if (updatedLoginState.hasError) {
                            final error = updatedLoginState.error;
                            _clearData(ref);
                            ToastHelper.showErrorToast(
                              context,
                              error.toString(),
                            );
                            print("Login failed: $error");
                          } else if (updatedLoginState.hasValue) {
                            _clearData(ref);
                            final user = updatedLoginState.value;
                            if (user != null) {
                              SharedPreferenceHelper.save(
                                SharedPreferenceHelper.isQuestionScreen,
                                true,
                              );
                              SharedPreferenceHelper.save(
                                SharedPreferenceHelper.userName,
                                user.user?.displayName,
                              );
                              print(user);
                              ToastHelper.showSuccessToast(
                                context,
                                StringConstant.loginSuccess,
                              );
                            }
                            print("Login successful: ${user}");
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _clearData(WidgetRef ref) {
    ref.read(emailProvider.notifier).state = '';
    ref.read(passwordProvider.notifier).state = '';
    emailController.clear();
    passwordController.clear();
  }
}
