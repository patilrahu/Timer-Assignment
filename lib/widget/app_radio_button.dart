import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';

class AppRadioButton extends StatefulWidget {
  final bool isSelected;
  final void Function() onPressed;
  final double? borderRadius;

  const AppRadioButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    this.borderRadius = 30,
  });

  @override
  State<AppRadioButton> createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? HexColor(ColorConstant.primaryColor)
              : Colors.transparent,
          border: Border.all(
            color: widget.isSelected
                ? HexColor(ColorConstant.primaryColor)
                : HexColor(ColorConstant.greyBorderColor),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
        ),
        child: Visibility(
          visible: widget.isSelected,
          child: Icon(Icons.check, size: 15, color: Colors.white),
        ),
      ),
    );
  }
}
