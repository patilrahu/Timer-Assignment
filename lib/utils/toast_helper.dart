import 'dart:ui';

import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/widgets.dart';
import 'package:timer_app/widget/app_text.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static void showSuccessToast(BuildContext context, String messages) {
    toastification.show(
      context: context,
      showProgressBar: false,
      type: ToastificationType.success,
      alignment: AlignmentDirectional.topStart,
      style: ToastificationStyle.minimal,
      title: AppText(
        text: messages,
        fontSize: 14,
        maxLines: 3,
        // color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  static void showErrorToast(BuildContext context, String messages) {
    toastification.show(
      context: context,
      showProgressBar: false,
      type: ToastificationType.error,
      alignment: AlignmentDirectional.topStart,
      style: ToastificationStyle.minimal,
      title: AppText(
        text: messages,
        // color: Colors.black,
        fontSize: 14,
        maxLines: 5,
        fontWeight: FontWeight.w600,
      ),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
