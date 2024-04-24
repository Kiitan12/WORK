import 'package:flutter/material.dart';
import 'package:volun_tek/src/constants/app_style.dart';

import '../../../../../constants/colors.dart';

//filtertag widget that is selectable
class FilterTag extends StatelessWidget {
  const FilterTag({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // behaviour on tap
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? kYellow : kBlueAccent, //colour if selected
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(
          title,
          style: AppStyle.kRegular12.copyWith(
            color: isSelected
                ? Colors.black
                : Colors.white, // colour if not selected
          ),
        ),
      ),
    );
  }
}
