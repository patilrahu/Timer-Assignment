import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/constant/image_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/feature/home/ui/home.dart';
import 'package:timer_app/feature/question/view_model/question_view_model.dart';
import 'package:timer_app/utils/shared_preference_helper.dart';
import 'package:timer_app/utils/toast_helper.dart';
import 'package:timer_app/widget/app_background.dart';
import 'package:timer_app/widget/app_button.dart';
import 'package:timer_app/widget/app_checkBox.dart';
import 'package:timer_app/widget/app_radio_button.dart';
import 'package:timer_app/widget/app_text.dart';
import 'package:timer_app/widget/app_text_field.dart';

class Questions extends ConsumerStatefulWidget {
  const Questions({super.key});

  @override
  ConsumerState<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends ConsumerState<Questions> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  String? dob;
  // Map<String, dynamic> selectedAnswers = {
  //   StringConstant.questionText: null,
  //   StringConstant.doYouHavePhone: null,
  //   StringConstant.willYouAbleToGetPhone: null,
  //   StringConstant.doYouUseGoogleMaps: null,
  //   StringConstant.dateOfBirth: null,
  // };

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
                child: Consumer(
                  builder: (context, ref, child) {
                    final progress = ref.watch(progressProvider);
                    final selectedAnswers = ref.watch(answersProvider);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: LinearProgressIndicator(
                            value: progress,
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3.5,
                              ),
                          itemBuilder: (context, index) {
                            return Row(
                              spacing: 8,
                              children: [
                                AppCheckbox(
                                  onPressed: (value) {
                                    final questionKey =
                                        StringConstant.questionText;
                                    final optionValue =
                                        StringConstant.questionOption[index];
                                    List<String> options =
                                        selectedAnswers[questionKey] ?? [];
                                    setState(() {
                                      if (value) {
                                        if (!options.contains(optionValue)) {
                                          options.add(optionValue);
                                        }
                                      } else {
                                        options.remove(optionValue);
                                      }

                                      selectedAnswers[questionKey] = options;
                                    });
                                    ref
                                        .read(
                                          questionViewModelProvider.notifier,
                                        )
                                        .onAnswerChanged(
                                          ref,
                                          ref.read(answersProvider),
                                        );
                                  },
                                  borderRadius: 4,
                                ),
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

                        _shortQuestionWidget(
                          StringConstant.doYouHavePhone,
                          selectedAnswers,
                        ),
                        Visibility(
                          visible:
                              selectedAnswers[StringConstant.doYouHavePhone] ==
                              'No',
                          child: _shortQuestionWidget(
                            StringConstant.willYouAbleToGetPhone,
                            selectedAnswers,
                          ),
                        ),
                        _shortQuestionWidget(
                          StringConstant.doYouUseGoogleMaps,
                          selectedAnswers,
                        ),
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
                                controller: _dayController,
                                keyboardType: TextInputType.number,
                                hintText: 'DD',
                                onChanged: (value) {
                                  if (value != '') {
                                    _setDob(selectedAnswers);
                                    ref
                                        .read(
                                          questionViewModelProvider.notifier,
                                        )
                                        .onAnswerChanged(
                                          ref,
                                          ref.read(answersProvider),
                                        );
                                  }
                                },
                                maxLength: 2,
                              ),
                            ),
                            SizedBox(
                              width: 78,
                              child: AppTextfield(
                                textAlign: TextAlign.center,
                                maxLength: 2,
                                keyboardType: TextInputType.number,
                                controller: _monthController,
                                hintText: 'MM',
                                onChanged: (value) {
                                  if (value != '') {
                                    _setDob(selectedAnswers);
                                    ref
                                        .read(
                                          questionViewModelProvider.notifier,
                                        )
                                        .onAnswerChanged(
                                          ref,
                                          ref.read(answersProvider),
                                        );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 78,
                              child: AppTextfield(
                                maxLength: 4,
                                textAlign: TextAlign.center,
                                controller: _yearController,
                                hintText: 'YYYY',
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  if (value != '') {
                                    _setDob(selectedAnswers);
                                    ref
                                        .read(
                                          questionViewModelProvider.notifier,
                                        )
                                        .onAnswerChanged(
                                          ref,
                                          ref.read(answersProvider),
                                        );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            Consumer(
              builder: (context, ref, child) {
                final allAnswered = ref.watch(progressProvider);
                bool isLoading = ref.watch(isLoadingProvider);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 15),
                  child: AppButton(
                    title: StringConstant.continueText,
                    isEnable: allAnswered == 1.0,
                    isLoading: isLoading,
                    onPressed: () async {
                      final selectedAnswers = ref.watch(answersProvider);
                      final success = await ref
                          .read(questionViewModelProvider.notifier)
                          .saveDatainDatabase(selectedAnswers, ref);
                      if (success) {
                        SharedPreferenceHelper.save(
                          SharedPreferenceHelper.isQuestionScreen,
                          false,
                        );
                        SharedPreferenceHelper.save(
                          SharedPreferenceHelper.isLogin,
                          true,
                        );
                        ToastHelper.showSuccessToast(context, 'Answers saved!');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Home();
                            },
                          ),
                          (route) => false,
                        );
                      } else {
                        ToastHelper.showErrorToast(
                          context,
                          "Failed to save answers.",
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _setDob(Map<String, dynamic> selectedAnswers) {
    if (_dayController.text.length == 2 &&
        _monthController.text.length == 2 &&
        _yearController.text.length == 4) {
      selectedAnswers[StringConstant.dateOfBirth] =
          "${_dayController.text}-${_monthController.text}-${_yearController.text}";
    } else {
      selectedAnswers[StringConstant.dateOfBirth] = "";
    }
  }

  Widget _shortQuestionWidget(
    String question,
    Map<String, dynamic> selectedAnswers,
  ) {
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
            final option = StringConstant.yesNoOption[index];
            final isSelected = selectedAnswers[question] == option;
            return Row(
              spacing: 8,
              children: [
                AppRadioButton(
                  onPressed: () {
                    setState(() {
                      selectedAnswers[question] = option;
                    });
                    if (question == StringConstant.doYouHavePhone) {
                      if (selectedAnswers[question] == "No") {
                        ref.read(answersProvider.notifier).state.addAll({
                          StringConstant.willYouAbleToGetPhone: null,
                        });
                      } else {
                        ref
                            .read(answersProvider.notifier)
                            .state
                            .remove(StringConstant.willYouAbleToGetPhone);
                      }
                    }
                    ref
                        .read(questionViewModelProvider.notifier)
                        .onAnswerChanged(ref, ref.read(answersProvider));
                  },
                  isSelected: isSelected,
                ),
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
