import 'package:flutter/material.dart';

import '../../../../../constants/app_style.dart';
import '../../../../../constants/colors.dart';

/// Represents an interest item displayed in the UI
class Interest extends StatelessWidget {
  const Interest({
    super.key,
    required this.title,
    this.onTap,
    this.color,
  });

  final String title;
  final VoidCallback? onTap;
  final Color? color;

// build for the interest cards
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? kDarkBlue,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppStyle.kRegular14,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
