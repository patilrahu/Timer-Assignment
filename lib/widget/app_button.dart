import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/widget/app_text.dart';

class AppButton extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  String? buttonBackgroundColor = ColorConstant.primaryColor;
  bool? isEnable = false;
  AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isEnable,
    this.buttonBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          elevation: 0,
          backgroundColor: (isEnable ?? false)
              ? HexColor(buttonBackgroundColor ?? ColorConstant.primaryColor)
              : HexColor(ColorConstant.disableColor),
        ),
        onPressed: onPressed,
        child: Center(
          child: AppText(
            text: title,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: (isEnable ?? false)
                ? Colors.white
                : HexColor(ColorConstant.disableTextColor),
          ),
        ),
      ),
    );
  }
}
