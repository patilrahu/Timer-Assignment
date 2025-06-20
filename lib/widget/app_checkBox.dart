import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';

class AppCheckbox extends StatefulWidget {
  final void Function(bool value) onPressed;
  double? borderRadius = 30;
  AppCheckbox({super.key, required this.onPressed, this.borderRadius});

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onPressed(isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? HexColor(ColorConstant.primaryColor) : null,
          border: Border.all(
            color: isSelected
                ? HexColor(ColorConstant.primaryColor)
                : HexColor(ColorConstant.greyBorderColor),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
        ),
        height: 24,
        width: 24,
        child: Visibility(
          visible: isSelected,
          child: Icon(Icons.check, size: 15, color: Colors.white),
        ),
      ),
    );
  }
}
