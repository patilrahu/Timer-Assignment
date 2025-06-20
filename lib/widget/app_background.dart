import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBackground extends StatelessWidget {
  Widget child;
  AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: child),
    );
  }
}
