import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timer_app/constant/color_constant.dart';
import 'package:timer_app/widget/app_text.dart';

class AppTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  Widget? suffixIcon;
  bool? isObsecure;
  final List<TextInputFormatter>? inputFormatters;
  String? errorText;
  int? maxLength;
  int? maxLines;
  Color? fillColor;
  double? borderRadius;
  TextInputAction? textInputAction;
  bool? isEnable = true;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  TextCapitalization? textCapitalization;
  TextAlign? textAlign = TextAlign.start;
  AppTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.keyboardType,
    this.suffixIcon,
    this.inputFormatters,
    this.fillColor,
    this.errorText = "",
    this.isObsecure = false,
    this.textCapitalization,
    this.borderRadius = 10,
    this.maxLines = 1,
    this.maxLength,
    this.onSubmitted,
    this.isEnable = true,
    this.textAlign,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            textAlign: textAlign ?? TextAlign.start,
            enabled: isEnable,
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value);
              }
            },
            textInputAction: textInputAction,
            onSubmitted: (value) {
              if (onSubmitted != null) {
                onSubmitted!(value);
              }
            },
            maxLines: maxLines ?? 1,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            obscureText: isObsecure ?? false,
            obscuringCharacter: '●',

            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: HexColor(ColorConstant.textColor),
              // fontFamily: StringsConstant.appFontFamily,
              // color: textColor(context),
            ),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: TextStyle(
                color: HexColor(ColorConstant.placeHolderColor),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(ColorConstant.greyBorderColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(ColorConstant.greyBorderColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(ColorConstant.primaryColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(ColorConstant.greyBorderColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(ColorConstant.greyBorderColor),
                ),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
            ),
          ),
          Visibility(
            visible: errorText != "",
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 2),
              child: AppText(
                text: errorText ?? "",
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
