import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';

class BasicText extends StatelessWidget {
  final String title;

  const BasicText({super.key, required this.title});
  @override
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
