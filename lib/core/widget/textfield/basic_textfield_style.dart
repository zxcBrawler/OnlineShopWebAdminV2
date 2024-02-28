import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

TextStyle basicTextFieldStyle() {
  return GoogleFonts.hammersmithOne(
      textStyle: TextStyle(
          color: AppColors.darkBrown,
          letterSpacing: 3,
          fontSize: 20,
          fontWeight: FontWeight.w300));
}
