import 'package:flutter/material.dart';

import '../../../../common_widgets/tek_elevated_button.dart';
import '../../../../common_widgets/tek_text_field.dart';
import '../../../../constants/app_style.dart';
import '../../../../constants/colors.dart';
import '../../../../routing/routes.dart';

class ConfirmMail extends StatelessWidget {
  const ConfirmMail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: AppStyle.kHeading1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text('Email', style: AppStyle.kRegular20),
            const SizedBox(height: 4),
            const TekTextField(),
            const SizedBox(height: 85),
            TekElevatedButton(
              title: 'Send',
              onPressed: () => Navigator.pushNamed(context, resetPassword),
            ),
          ],
        ),
      ),
    );
  }
}
