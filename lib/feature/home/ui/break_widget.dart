import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timer_app/backend/firebase_auth_helper.dart';
import 'package:timer_app/backend/firebase_database.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/constant/image_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/feature/home/ui/break_over.dart';
import 'package:timer_app/feature/home/view_model/home_view_model.dart';
import 'package:timer_app/widget/app_button.dart';
import 'package:timer_app/widget/app_text.dart';

class BreakWidget extends ConsumerStatefulWidget {
  const BreakWidget({super.key});

  @override
  ConsumerState<BreakWidget> createState() => _BreakWidgetState();
}

class _BreakWidgetState extends ConsumerState<BreakWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(breakData.notifier).fetchBreakData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: AlignmentDirectional(-1.0, -1.0),
          end: AlignmentDirectional(1.0, 1.0),
          stops: [0.0, 0.46, 0.99],
          colors: [
            HexColor(ColorConstant.gradientColor1),
            HexColor(ColorConstant.gradientColor2),
            HexColor(ColorConstant.gradientColor3),
          ],
          transform: GradientRotation(151.92 * 3.1416 / 180),
        ),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final breakState = ref.watch(breakData);

          return breakState.when(
            data: (data) {
              if (data == null || data['start_time'] == null) {
                return AppText(text: 'Break not Started');
              }

              final DateTime startTime = data['start_time'] is String
                  ? DateTime.parse(data['start_time'])
                  : data['start_time'] as DateTime;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: AppText(
                      text: StringConstant.breakText,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: AppText(
                      text: StringConstant.breakSubText,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 31),
                  ClipRect(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          heightFactor: 0.85,
                          child: CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 15.0,

                            center: Align(
                              alignment: Alignment.center,
                              child: AppText(
                                text: _getElapsedTime(startTime),
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            arcBackgroundColor: HexColor(
                              ColorConstant.arcColor,
                            ),
                            percent: _calculatePercent(
                              DateTime.now().difference(startTime),
                            ),
                            arcType: ArcType.FULL,
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.white,
                          ),
                        ),

                        Positioned.fill(
                          bottom: -5,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: AppText(
                              text: 'Break',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 14,
                          top: 10,
                          child: Image.asset(ImageConstant.smallStarImage),
                        ),
                        Positioned(
                          left: 14,
                          top: 10,
                          child: Image.asset(ImageConstant.bigStarImage),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 30,
                          child: Image.asset(ImageConstant.bigStarImage),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 38),
                  Divider(color: HexColor(ColorConstant.blueColor)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText(
                      text: 'Break ends at ${_getBreakEndTime(startTime)}',
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(color: HexColor(ColorConstant.blueColor)),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: AppButton(
                      title: StringConstant.endMyBreak,
                      onPressed: () {
                        showBreakBottomSheet();
                      },
                      isEnable: true,
                      buttonBackgroundColor: ColorConstant.redColor,
                    ),
                  ),
                ],
              );
            },
            loading: () => const CircularProgressIndicator(color: Colors.white),
            error: (error, stack) => BreakOver(),
          );
        },
      ),
    );
  }

  String _getElapsedTime(DateTime breakStartTime) {
    final Duration elapsed = DateTime.now().difference(breakStartTime);
    final minutes = elapsed.inMinutes.remainder(60);
    final seconds = elapsed.inSeconds.remainder(60);

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  String _getBreakEndTime(DateTime breakStartTime) {
    final breakEnd = breakStartTime.add(const Duration(minutes: 30));
    return _formatTime(breakEnd);
  }

  String _formatTime(DateTime time) {
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$minute $period';
  }

  double _calculatePercent(Duration elapsed) {
    final percent = elapsed.inSeconds / (30 * 60);
    return percent.clamp(0.0, 1.0);
  }

  void showBreakBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 232,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 36,
                decoration: BoxDecoration(
                  color: HexColor(ColorConstant.lightGreyColor),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: AppText(text: ''),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: AppText(
                  text: StringConstant.endingBreakEarly,
                  fontSize: 20,
                  fontFamily: GoogleFonts.metrophobic().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: AppText(
                  text: StringConstant.endingBreakEarlySubText,
                  textAlign: TextAlign.center,
                  fontSize: 15,
                  fontFamily: GoogleFonts.metrophobic().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppButton(
                        isEnable: true,
                        buttonBackgroundColor: ColorConstant.greenColor,
                        title: StringConstant.continueText,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await FirebaseDatabaseHelper.endBreakNow();
                          ref.read(breakData.notifier).fetchBreakData();
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: HexColor(ColorConstant.lightRedColor),
                            ),
                          ),
                          child: AppText(
                            text: StringConstant.endNowText,
                            fontSize: 15,
                            color: HexColor(ColorConstant.lightRedColor),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
