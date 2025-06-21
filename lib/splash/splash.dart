import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_app/feature/login/ui/login.dart';
import 'package:timer_app/feature/question/ui/questions.dart';
import 'package:timer_app/utils/shared_preference_helper.dart';
import 'package:timer_app/widget/app_background.dart';
import 'package:timer_app/widget/app_text.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToScreen();
  }

  void _navigateToScreen() async {
    var isQuestionScreen = await SharedPreferenceHelper.getValue(
      SharedPreferenceHelper.isQuestionScreen,
    );
    if (isQuestionScreen == null || isQuestionScreen == false) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Questions();
          },
        ),
        (route) => false,
      );
    } else if (isQuestionScreen == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Questions();
          },
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Center(
        child: AppText(
          text: 'Welcome',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.metrophobic().fontFamily,
        ),
      ),
    );
  }
}
