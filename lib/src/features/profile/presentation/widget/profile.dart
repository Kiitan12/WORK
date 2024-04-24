import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volun_tek/src/constants/app_style.dart';
import 'package:volun_tek/src/routing/routes.dart';
import 'package:badges/badges.dart' as badge;

import '../../../../constants/colors.dart';
import 'refactored/profile_tile.dart';
import 'refactored/volunteer_type.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          'Profile',
          style: AppStyle.kHeading1.copyWith(
            color: kGray16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: badge.Badge(
                  badgeStyle: badge.BadgeStyle(
                    badgeColor: kYellow,
                    elevation: 0,
                  ),
                  badgeContent: Icon(Icons.edit, color: kBlueAccent),
                  child: CircleAvatar(
                    radius: 43,
                    backgroundColor: kBlue,
                    child: Icon(
                      Icons.person,
                      size: 60,
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
              const SizedBox(height: 28),
              Text(
                'ACCOUNT',
                style: AppStyle.kRegular16Inter.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileTile(
                    imgUrl: 'assets/svg/history.svg',
                    title: 'History',
                    onTap: () => Navigator.pushNamed(context, history),
                  ),
                  const ProfileTile(
                    imgUrl: 'assets/svg/badge.svg',
                    title: 'Badges',
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileTile(
                    imgUrl: 'assets/svg/favourite.svg',
                    title: 'Favourite',
                    onTap: () => Navigator.pushNamed(context, favourite),
                  ),
                  ProfileTile(
                      imgUrl: 'assets/svg/edit_profile.svg',
                      title: 'Edit profile',
                      onTap: () {
                        Navigator.pushNamed(context, editProfile);
                      }),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'SETTINGS',
                style: AppStyle.kRegular16Inter.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileTile(
                    imgUrl: 'assets/svg/sign_out.svg',
                    title: 'Sign out',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Sign out'),
                              content: const Text(
                                  'Are you sure you want to sign out?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pushNamed(context, loggingState);
                                  },
                                  child: const Text('Sign out'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'SUPPORT',
                style: AppStyle.kRegular16Inter.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 40),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileTile(
                    imgUrl: 'assets/svg/phone.svg',
                    title: 'Contact us',
                    isCentered: false,
                  ),
                  SizedBox(height: 40),
                  ProfileTile(
                    imgUrl: 'assets/svg/terms.svg',
                    title: 'Terms & Conditions',
                    isCentered: false,
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

