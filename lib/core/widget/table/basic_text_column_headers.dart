import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class BasicTextColumnHeaders extends StatelessWidget {
  final String title;

  const BasicTextColumnHeaders({super.key, required this.title});
  @override

  /// Widget for displaying a column header in a table.
  ///
  /// The [title] parameter is the text that will be displayed in the header.
  @override
  Widget build(BuildContext context) {
    // Padding adds spacing around the text widget.
    return Padding(
      padding: const EdgeInsets.all(2.0), // Applies padding on all sides.
      child: Text(
        title, // Text of the header.
        style: GoogleFonts.hammersmithOne(
          textStyle: TextStyle(
            color: AppColors.darkBrown, // Color of the text.
            fontWeight: FontWeight.bold, // Bold text.
            fontSize: 20, // Size of the font.
          ),
        ),
      ),
    );
  }
}
