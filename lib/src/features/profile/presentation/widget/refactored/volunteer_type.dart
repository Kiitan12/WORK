import 'package:flutter/material.dart';

import '../../../../../constants/app_style.dart';
import '../../../../../constants/colors.dart';

class VolunteerType extends StatelessWidget {
  const VolunteerType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 148,
        decoration: BoxDecoration(
          color: kYellow,
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text('Golden Volunteer',
            style: AppStyle.kRegular16Inter.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            )),
      ),
    );
  }
}
