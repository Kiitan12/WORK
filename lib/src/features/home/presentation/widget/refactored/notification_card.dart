import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/app_style.dart';
import '../../../../../constants/colors.dart';

// notification card widget
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
  });

  final String title;
  final String description;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyle.kRegular16Inter.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '2W',
                style: AppStyle.kRegular10,
              )
            ],
          ),
          Text(
            description,
            style: AppStyle.kRegular14.copyWith(
              color: kGray,
            ),
          ),
        ],
      ),
    );
  }
}
