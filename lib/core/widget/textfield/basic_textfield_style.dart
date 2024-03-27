import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

/// Returns a [TextStyle] for a basic text field.
///
/// This style includes a custom font, dark brown color, letter spacing of 3,
/// font size of 20, and a font weight of w300.
///
/// The returned [TextStyle] can be used to style a [TextField] widget.
TextStyle basicTextFieldStyle() {
  return GoogleFonts.hammersmithOne(
    textStyle: TextStyle(
      // Color of the text.
      color: AppColors.darkBrown,
      // Spacing between characters.
      letterSpacing: 3,
      // Size of the font.
      fontSize: 20,
      // Weight of the font.
      fontWeight: FontWeight.w300,
    ),
  );
}
