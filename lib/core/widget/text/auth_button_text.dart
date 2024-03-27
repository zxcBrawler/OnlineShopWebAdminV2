import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class AuthButtonText extends StatelessWidget {
  final String title;
  const AuthButtonText({super.key, required this.title});

  @override

  /// A stateless widget that renders a text widget with the given [title].
  ///
  /// This widget wraps the [Text] widget with padding. The text style
  /// includes a font family, color, letter spacing, and font size.
  ///
  /// Parameters:
  /// - [title]: A [String] representing the text to be rendered.
  ///
  /// Returns:
  /// - A [Padding] widget that wraps the [Text] widget.
  @override
  Widget build(BuildContext context) {
    return Padding(
      // Apply padding to all sides with a value of 10.0.
      padding: const EdgeInsets.all(10.0),
      // Render the [title] text with customized style.
      child: Text(
        title,
        style: GoogleFonts.hammersmithOne(
          // Specify the text style.
          textStyle: TextStyle(
            // The color of the text.
            color: AppColors.white,
            // The letter spacing of the text.
            letterSpacing: 2,
            // The font size of the text.
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
