import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/colors.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    this.isSelected = false,
    required this.title,
    required this.image,
    required this.onPressed,
  });

  final bool isSelected;
  final String title;
  final String image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: isSelected? kYellow : kSeaShell, width: 6),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kDarkBlue,
          ),
        )
      ],
    );
  }
}
