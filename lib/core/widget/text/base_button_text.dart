import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class BaseButtonText extends StatelessWidget {
  final String title;
  const BaseButtonText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: GoogleFonts.hammersmithOne(
            textStyle: TextStyle(
                color: AppColors.white, letterSpacing: 2, fontSize: 20)),
      ),
    );
  }
}
