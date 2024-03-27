import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class SideMenuTitle extends StatelessWidget {
  final String title;

  const SideMenuTitle({super.key, required this.title});
  @override

  /// Widget representing a title in the side menu.
  ///
  /// This widget displays the [title] passed to it as a [Text] widget.
  /// It uses the Hammersmith One font from the Google Fonts library and
  /// applies the color and font size defined in [AppColors.darkBrown] and 16
  /// respectively.
  ///

  @override
  Widget build(BuildContext context) {
    // Return a Text widget displaying the title with the specified style
    return Text(
      title,
      style: GoogleFonts.hammersmithOne(
        textStyle: TextStyle(
          color: AppColors.darkBrown,
          fontSize: 16,
        ),
      ),
    );
  }
}
