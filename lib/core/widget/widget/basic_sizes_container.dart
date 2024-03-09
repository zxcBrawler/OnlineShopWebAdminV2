import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/widget/text/auth_button_text.dart';

class SizesContainer extends StatelessWidget {
  final String title;
  const SizesContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        decoration: BoxDecoration(
            color: AppColors.darkBrown,
            borderRadius: BorderRadius.circular(30)),
        child: Center(child: AuthButtonText(title: title)));
  }
}
