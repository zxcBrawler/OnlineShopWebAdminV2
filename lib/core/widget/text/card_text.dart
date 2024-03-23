import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class CardText extends StatelessWidget {
  final String title;
  const CardText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: GoogleFonts.hammersmithOne(
            textStyle: TextStyle(
                color: AppColors.lightGray, letterSpacing: 2, fontSize: 15)),
      ),
    );
  }
}
