import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

// Class containing various text styles used in the app
class AppStyle {
  static TextStyle kHeading1 = GoogleFonts.dmSerifDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: kDarkBlue,
  );

// Text style for regular text
  static TextStyle kRegular20 = GoogleFonts.dmSerifDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: kDarkBlue,
  );

  // Text style for regular text
  static TextStyle kRegular16 = GoogleFonts.dmSerifDisplay(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  // Text style for regular text
  static TextStyle kRegular16Inter = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: kGray65,
  );

  // Text style for regular text
  static TextStyle kRegular14 = GoogleFonts.dmSerifDisplay(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  // Text style for regular text
  static TextStyle kRegular12 = GoogleFonts.dmSerifDisplay(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kGray65,
  );

  // Text style for regular text
  static TextStyle kRegular12Inter = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: kGray16,
  );

  // Text style for regular text
  static TextStyle kRegular10 = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: kGray65,
  );

  // No border text field decoration
  static OutlineInputBorder kNoBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide.none,
  );
}
