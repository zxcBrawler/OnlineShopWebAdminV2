import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';

final ThemeData appTheme = ThemeData(
    useMaterial3: false,
    inputDecorationTheme: InputDecorationTheme(
        focusColor: AppColors.darkBrown,
        floatingLabelStyle: GoogleFonts.hammersmithOne(
            textStyle: TextStyle(
                fontSize: 20, color: AppColors.darkBrown, letterSpacing: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: AppColors.darkBrown,
                width: 3,
                style: BorderStyle.solid)),
        labelStyle: GoogleFonts.hammersmithOne(
            textStyle: const TextStyle(fontSize: 20, letterSpacing: 2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.darkBrown, selectionColor: AppColors.lightGray),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: AppColors.darkBrown));
