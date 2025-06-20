import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
          const SizedBox(height: 38),
          Divider(color: HexColor(ColorConstant.blueColor)),
          Padding(
            padding: const EdgeInsets.all(16.0),
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
      // isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: StringConstant.endingBreakEarly,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            AppText(
              text: StringConstant.endingBreakEarlySubText,
              textAlign: TextAlign.center,
              fontSize: 15,
              fontFamily: GoogleFonts.metrophobic().fontFamily,
              fontWeight: FontWeight.w500,
            ),
            Row(children: []),
          ],
        );
      },
    );
  }
}
