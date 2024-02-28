import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class BasicTextColumnData extends StatelessWidget {
  final String title;
  const BasicTextColumnData({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        title,
        style: GoogleFonts.hammersmithOne(
            textStyle: TextStyle(
                color: AppColors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
