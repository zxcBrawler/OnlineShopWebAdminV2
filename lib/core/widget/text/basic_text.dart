import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';

class BasicText extends StatelessWidget {
  final String title;

  const BasicText({super.key, required this.title});
  @override

  /// Builds a [Text] widget with the provided [title].
  ///
  /// The [Text] widget is wrapped in a [Padding] widget with a padding of 25.0
  /// on all sides. The [Text] widget is styled using the Google Fonts
  /// 'Hammersmith One' font and has a color of [AppColors.darkBrown]. The font
  /// size is determined based on the device's screen size using the
  /// [Responsive.isMobile] method. If the device is a mobile device, the font
  /// size is 20. Otherwise, it is 30.
  ///
  /// Parameters:
  ///   - context: The build context of the widget tree.
  ///
  /// Returns:
  ///   - A [Text] widget wrapped in a [Padding] widget.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Text(
        title,
        style: GoogleFonts.hammersmithOne(
            textStyle: TextStyle(
                color: AppColors.darkBrown,
                fontSize: Responsive.isMobile(context) ? 20 : 30)),
      ),
    );
  }
}
