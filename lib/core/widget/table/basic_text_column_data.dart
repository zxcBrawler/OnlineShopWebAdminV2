import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class BasicTextColumnData extends StatelessWidget {
  final String title;
  const BasicTextColumnData({super.key, required this.title});

  @override

  /// Builds a widget that displays a [title] in a centered [Text] widget.
  ///
  /// The [title] is padded by 2 pixels on all sides and displayed using the
  /// [GoogleFonts.hammersmithOne] font with the following styles:
  /// - Color: [AppColors.black]
  /// - Font size: 15
  /// - Font weight: [FontWeight.bold]
  @override
  Widget build(BuildContext context) {
    // The padding around the text widget.
    const EdgeInsets padding = EdgeInsets.all(2.0);

    // The text widget displaying the [title] with the specified style.
    final Widget textWidget = Padding(
      padding: padding,
      child: Text(
        title,
        style: GoogleFonts.hammersmithOne(
          textStyle: TextStyle(
            color: AppColors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return textWidget;
  }
}
