import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class HeaderText extends StatelessWidget {
  final double textSize;
  final String title;
  const HeaderText({super.key, required this.textSize, required this.title});
  @override

  /// Builds a stateless widget that displays a header text.
  ///
  /// The widget has padding of 16 on all sides and displays the [title]
  /// with the provided [textSize] using the Google Fonts 'Hammersmith One'.
  /// The text color is set to [AppColors.darkBrown].
  ///
  /// Parameters:
  /// - `context`: The build context.
  ///
  /// Returns: A `Padding` widget with `EdgeInsets.all(16.0)` and a `Text` widget
  /// with the provided [title] and [textSize].
  @override
  Widget build(BuildContext context) {
    return Padding(
      // Adds padding of 16 on all sides
      padding: const EdgeInsets.all(16.0),
      child: Text(
        // Displays the [title]
        title,
        style: GoogleFonts.hammersmithOne(
            // Uses the Google Fonts 'Hammersmith One'
            textStyle: TextStyle(
                // Sets the text color to [AppColors.darkBrown]
                color: AppColors.darkBrown,
                // Sets the text size to the provided [textSize]
                fontSize: textSize)),
      ),
    );
  }
}
