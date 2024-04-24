import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volun_tek/globals.dart';
import 'package:volun_tek/src/constants/colors.dart';
import 'package:volun_tek/src/routing/routes.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int? initScreen;

  @override
  void initState() {
    super.initState();
    oneTimeOnBoarding();
    navigateToOnBoarding();
  }

  /// oneTimeOneOnBoarding method is used with SharedPreferences to show the Onboarding view only once.
  void oneTimeOnBoarding() async {
    final preferences = await SharedPreferences.getInstance();
    initScreen = preferences.getInt("initScreen");
    await preferences.setInt("initScreen", 1);
  }

  navigateToOnBoarding() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    initScreen == 0 || initScreen == null
        ? navigatorKey.currentState!.pushNamed(signup) :
        navigatorKey.currentState!.pushNamedAndRemoveUntil(loggingState, (route) => false);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 54.0 + MediaQuery.of(context).padding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Explore & \nMake a \nDifference',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 48,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 60),
            InkWell(
              onTap: () => Navigator.pushNamed(context, interest),
              child: const CircleAvatar(
                backgroundColor: kYellow,
                child: Icon(Icons.arrow_forward_ios_rounded, size: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
