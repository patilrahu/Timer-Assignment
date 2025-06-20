import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/widget/app_button.dart';
import 'package:timer_app/widget/app_text.dart';

class BreakWidget extends StatefulWidget {
  const BreakWidget({super.key});

  @override
  State<BreakWidget> createState() => _BreakWidgetState();
}

class _BreakWidgetState extends State<BreakWidget> {
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
      child: Column(
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
                        text: "02:42",
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    arcBackgroundColor: HexColor(ColorConstant.arcColor),
                    percent: 0.5,
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
              ],
            ),
          ),
          const SizedBox(height: 38),
          Divider(color: HexColor(ColorConstant.blueColor)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              text: 'Break ends at 01:30 PM',
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
      ),
    );
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
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
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
