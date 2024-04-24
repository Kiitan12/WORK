import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/common_widgets/tek_text_field.dart';
import 'package:volun_tek/src/features/profile/presentation/controller/user_controller.dart';

import '../../../../common_widgets/tek_elevated_button.dart';
import '../../../../constants/app_style.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/validation_helper.dart';
import '../provider/user_provider.dart';

// Widget for editing user profile
class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.validation,
    required this.controller,
  });

  final ValidationHelper validation;
  final UserController controller;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
      // body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SingleChildScrollView(
          child: Consumer(builder: (context, ref, child) {
            // watch user data provider
            final user = ref.watch(getUserProvider);
            return user.when(
                data: (data) => Form(
                      key: widget.controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          const Center(
                            // user avatar edit
                            child: badge.Badge(
                              badgeStyle: badge.BadgeStyle(
                                badgeColor: kYellow,
                                elevation: 0,
                              ),
                              badgeContent:
                                  Icon(Icons.edit, color: kBlueAccent),
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
                          const SizedBox(height: 40),
                          // name text field
                          Text('Name', style: AppStyle.kRegular20),
                          const SizedBox(height: 4),
                          TekTextField(
                            hint: user.value!['name'],
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          // email text field
                          Text('Email', style: AppStyle.kRegular20),
                          const SizedBox(height: 4),
                          TekTextField(
                            hint: user.value!['email'],
                            enabled: false,
                          ),
                          const SizedBox(height: 16),
                          // location text field
                          Text('Location', style: AppStyle.kRegular20),
                          const SizedBox(height: 4),
                          TekTextField(
                            hint: user.value!['location'] ??
                                'Enter your location',
                            inputController: widget.controller.location,
                            validator: (value) {
                              return widget.validation.validateField(value!);
                            },
                          ),
                          const SizedBox(height: 16),
                          // bio text field
                          Text('Bio', style: AppStyle.kRegular20),
                          const SizedBox(height: 4),
                          TekTextField(
                            hint:
                                user.value!['bio'] ?? 'Tell us about yourself',
                            inputController: widget.controller.bio,
                            validator: (value) {
                              return widget.validation.validateField(value!);
                            },
                            maxLines: 2,
                          ),
                          const SizedBox(height: 28),
                          // save update button
                          Center(
                            child: TekElevatedButton(
                              child: ref.watch(updateUserProfileProvider)
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Save',
                                      style: AppStyle.kRegular16,
                                    ),
                              onPressed: () {
                                // Validate form
                                if (widget.controller.formKey.currentState!
                                    .validate()) {
                                  final data = {
                                    'location':
                                        widget.controller.location.text.trim(),
                                    'bio': widget.controller.bio.text.trim(),
                                  };
                                  //update user profile
                                  ref
                                      .read(updateUserProfileProvider.notifier)
                                      .updateUserProfile(data)
                                      .then((value) =>
                                          ref.refresh(getUserProvider));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                // error state
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      'Error: $error',
                      style: AppStyle.kRegular16.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                // loading state
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kBlueAccent,
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}
