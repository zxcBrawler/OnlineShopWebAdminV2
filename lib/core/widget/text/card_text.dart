import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class CardText extends StatelessWidget {
  final String title;
  const CardText({super.key, required this.title});

  @override

  /// Builds a [Text] widget that displays the [title] of the card.
  ///
  /// This method returns a [Padding] widget that wraps a [Text] widget. The
  /// [Text] widget displays the [title] with a maximum of 3 lines. The text is
  /// styled using the 'Hammersmith One' font from the Google Fonts library, with
  /// a color of [AppColors.lightGray], a letter spacing of 2, and a font size of 15.
  ///
  /// Parameters:
  ///   - context: The [BuildContext] of the widget.
  ///
  /// Returns:
  ///   A [Padding] widget that wraps a [Text] widget.
  Widget build(BuildContext context) {
    // Add padding around the text widget
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        // Set the maximum number of lines to display
        maxLines: 3,
        // Display the title of the card
        title,
        // Style the text using the 'Hammersmith One' font
        style: GoogleFonts.hammersmithOne(
          textStyle: TextStyle(
            // Set the color to light gray
            color: AppColors.lightGray,
            // Set the letter spacing to 2
            letterSpacing: 2,
            // Set the font size to 15
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
