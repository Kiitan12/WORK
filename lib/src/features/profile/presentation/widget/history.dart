import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:volun_tek/src/features/profile/presentation/widget/refactored/history_card.dart';

import '../../../../constants/app_style.dart';
import '../../../../constants/colors.dart';
import 'refactored/profile_tile.dart';
import 'refactored/volunteer_type.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: Text(
          'History',
          style: AppStyle.kHeading1.copyWith(
            color: kGray16,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: badge.Badge(
              badgeStyle: const badge.BadgeStyle(
                badgeColor: kYellow,
                elevation: 0,
              ),
              badgeContent: const Icon(Icons.edit, color: kBlueAccent),
              child: CircleAvatar(
                radius: 43,
                backgroundColor: kBlue,
                child: Image.asset(
                  'assets/images/profile.png',
                  height: 76,
                  width: 76,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const ProfileTile(
            imgUrl: 'assets/svg/check_circle.svg',
            title: '100 hrs completed',
          ),
          const SizedBox(height: 12),
          const VolunteerType(),
          const SizedBox(height: 32),
          const Divider(color: kBlueAccent),
          const HistoryCard(),
          const Divider(color: kBlueAccent),
        ],
      ),
    );
  }
}

