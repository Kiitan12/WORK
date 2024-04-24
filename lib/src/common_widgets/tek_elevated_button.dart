import 'package:flutter/material.dart';
import 'package:volun_tek/src/constants/app_style.dart';

import '../constants/colors.dart';

// Custom elevated button widget
class TekElevatedButton extends StatelessWidget {
  const TekElevatedButton({
    super.key,
    this.title,
    required this.onPressed, // Callback function when button is pressed
    this.buttonColor,
    this.child,
  });

  final String? title; // Button title
  final VoidCallback onPressed; // Callback function when button is pressed
  final Color? buttonColor; // Button color
  final Widget? child; // Custom child widget

  // building the button
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? kBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: child ?? Text(title ?? '', style: AppStyle.kRegular16),
        ),
      ),
    );
  }
}
