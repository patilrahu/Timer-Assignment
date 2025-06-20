import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBackground extends StatelessWidget {
  bool? requiredSafeArea = true;
  Widget child;
  AppBackground({super.key, required this.child, this.requiredSafeArea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(top: requiredSafeArea ?? true, child: child),
    );
  }
}
