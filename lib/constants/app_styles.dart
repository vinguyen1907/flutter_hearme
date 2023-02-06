import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hear_me/constants/app_color.dart';

class AppStyles {
  static TextStyle buttonText = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5);

  static TextStyle onboardingTitle = GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5);
  static TextStyle headerText = GoogleFonts.poppins(
    color: AppColors.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static TextStyle dialogItemText = GoogleFonts.poppins(
    color: AppColors.textColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle hintText = GoogleFonts.poppins(
    color: Colors.grey[500],
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1,
  );
  static TextStyle inputText = GoogleFonts.poppins(
    color: AppColors.textColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1,
  );
}
