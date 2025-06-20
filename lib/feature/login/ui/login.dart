import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/feature/question/ui/questions.dart';
import 'package:timer_app/widget/app_background.dart';
import 'package:timer_app/widget/app_button.dart';
import 'package:timer_app/widget/app_checkBox.dart';
import 'package:timer_app/widget/app_text.dart';
import 'package:timer_app/widget/app_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      controller: emailController,
                      hintText: StringConstant.enterUserName,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: AppTextfield(
                      controller: passwordController,
                      isObsecure: true,
                      hintText: StringConstant.enterPassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
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
                  child: AppButton(
                    title: StringConstant.continueText,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Questions();
                          },
                        ),
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
}
