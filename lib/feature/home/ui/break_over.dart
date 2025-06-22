import 'package:flutter/material.dart';
import 'package:timer_app/constant/image_constant.dart';
import 'package:timer_app/constant/string_constant.dart';
import 'package:timer_app/widget/app_text.dart';

class BreakOver extends StatelessWidget {
  const BreakOver({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 64),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(90),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(90),
              ),
              child: Image.asset(ImageConstant.correctImage),
            ),
          ),
        ),
        const SizedBox(height: 24),
        AppText(
          text: StringConstant.breakOverSuceess,
          fontSize: 17,
          color: Colors.white,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 52),
      ],
    );
  }
}
