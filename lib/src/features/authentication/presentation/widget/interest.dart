import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volun_tek/src/constants/colors.dart';
import 'package:volun_tek/src/routing/routes.dart';

import '../../../../common_widgets/tek_elevated_button.dart';
import 'refactored/interest_card.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  final images = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img4.png',
    'assets/images/img3.png',
    'assets/images/img5.png',
    'assets/images/img6.png',
    'assets/images/img7.png',
    'assets/images/img8.png',
  ];

  final titles = [
    'Elder Care',
    'Animal Welfare',
    'Social Service',
    'Education',
    'Environment',
    'Art % Culture',
    'International Development',
    'Healthcare',
  ];

  final interests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const SizedBox(), actions: [
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            Navigator.pop(context, '/signup');
          },
        )
      ]),
      body: Padding(
        padding: EdgeInsets.only(
          left: 32.0,
          right: 32.0,
          top: 32.0 + MediaQuery.of(context).padding.top,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interests',
                style: GoogleFonts.dmSerifDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: kDarkBlue),
              ),
              const SizedBox(height: 24),
              Text(
                'Tell us what causes interest you. '
                'This will help us match you with the right opportunity',
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: kDarkBlue,
                ),
              ),
              const SizedBox(height: 0),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 190,
                  mainAxisSpacing: 24,
                ),
                itemCount: titles.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InterestCard(
                    title: titles.elementAt(index),
                    image: images.elementAt(index),
                    isSelected: interests.contains(titles.elementAt(index)),
                    onPressed: () {
                      setState(() {
                        if (interests.contains(titles.elementAt(index))) {
                          interests.remove(titles.elementAt(index));
                        } else {
                          interests.add(titles.elementAt(index));
                        }
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 32),
              TekElevatedButton(
                title: 'Submit',
                onPressed: interests.isEmpty
                    ? () {}
                    : () => Navigator.pushNamed(context, login),
                buttonColor: interests.isEmpty ? kBlueAccent : kBlue,
              ),
              const SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
