import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class HeaderText extends StatelessWidget {
  final double textSize;
  final String title;
  const HeaderText({super.key, required this.textSize, required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: GoogleFonts.hammersmithOne(
            textStyle:
                TextStyle(color: AppColors.darkBrown, fontSize: textSize)),
      ),
    );
  }
}
