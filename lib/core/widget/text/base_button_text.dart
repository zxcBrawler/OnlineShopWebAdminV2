import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class BaseButtonText extends StatelessWidget {
  final String title;
  const BaseButtonText({super.key, required this.title});

  @override

  /// Builds a [Text] widget that represents the title of a button.
  ///
  /// The [title] parameter is the text that will be displayed in the button.
  /// The widget is wrapped in a [Padding] widget to add some spacing around it.
  /// The [Text] widget is styled using the [GoogleFonts.hammersmithOne] font and
  /// the [TextStyle] class. The text color is set to [AppColors.white], the
  /// letter spacing is set to 2, and the font size is set to 20.
  ///
  /// Returns:
  /// A [Text] widget that represents the title of the button.
  Widget build(BuildContext context) {
    return Padding(
      // Add padding around the text widget
      padding: const EdgeInsets.all(10.0),
      child: Text(
        // Create a Text widget with the provided title
        title,
        style: GoogleFonts.hammersmithOne(
          // Style the text using the HammersmithOne font
          textStyle: TextStyle(
            // Set the text color to white
            color: AppColors.white,
            // Add letter spacing of 2
            letterSpacing: 2,
            // Set the font size to 20
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
