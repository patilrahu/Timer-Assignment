import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/constant/image_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/feature/home/ui/home.dart';
import 'package:timer_app/widget/app_background.dart';
import 'package:timer_app/widget/app_button.dart';
import 'package:timer_app/widget/app_checkBox.dart';
import 'package:timer_app/widget/app_radio_button.dart';
import 'package:timer_app/widget/app_text.dart';
import 'package:timer_app/widget/app_text_field.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: LinearProgressIndicator(
                        value: 1,
                        minHeight: 5,
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: HexColor(
                          ColorConstant.greyBorderColor,
                        ),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          HexColor(ColorConstant.progressColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: AppText(
                        text: StringConstant.skillText,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: HexColor(ColorConstant.textColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: AppText(
                        text: StringConstant.skillSubHeading,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: HexColor(ColorConstant.privacyPolicyColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: AppText(
                        text: StringConstant.questionText,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HexColor(ColorConstant.textColor),
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: StringConstant.questionOption.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,

                        childAspectRatio: 3.5,
                      ),
                      itemBuilder: (context, index) {
                        return Row(
                          spacing: 8,
                          children: [
                            AppCheckbox(onPressed: (value) {}, borderRadius: 4),
                            Expanded(
                              child: AppText(
                                text: StringConstant.questionOption[index],
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: HexColor(
                                  ColorConstant.privacyPolicyColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    _shortQuestionWidget(StringConstant.doYouHavePhone),
                    _shortQuestionWidget(StringConstant.doYouUseGoogleMaps),
                    Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 8),
                      child: AppText(
                        text: StringConstant.dateOfBirth,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: HexColor(ColorConstant.textColor),
                      ),
                    ),
                    Row(
                      spacing: 8,

                      children: [
                        SizedBox(
                          width: 78,
                          child: AppTextfield(
                            textAlign: TextAlign.center,
                            controller: TextEditingController(),
                            hintText: 'DD',
                            maxLength: 2,
                          ),
                        ),
                        SizedBox(
                          width: 78,
                          child: AppTextfield(
                            textAlign: TextAlign.center,
                            maxLength: 2,
                            controller: TextEditingController(),
                            hintText: 'MM',
                          ),
                        ),
                        SizedBox(
                          width: 78,
                          child: AppTextfield(
                            maxLength: 4,
                            textAlign: TextAlign.center,
                            controller: TextEditingController(),
                            hintText: 'YYYY',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                        return Home();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shortQuestionWidget(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: AppText(
            text: question,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: HexColor(ColorConstant.textColor),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16),
          itemCount: StringConstant.yesNoOption.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,

            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            return Row(
              spacing: 8,
              children: [
                AppRadioButton(onPressed: () {}, isSelected: true),
                Expanded(
                  child: AppText(
                    text: StringConstant.yesNoOption[index],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: HexColor(ColorConstant.privacyPolicyColor),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
