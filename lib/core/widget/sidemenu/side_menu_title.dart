import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

class SideMenuTitle extends StatelessWidget {
  final String title;

  const SideMenuTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.hammersmithOne(
          textStyle: TextStyle(color: AppColors.darkBrown, fontSize: 16)),
    );
  }
}
