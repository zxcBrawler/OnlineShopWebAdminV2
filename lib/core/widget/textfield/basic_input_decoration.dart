import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';

InputDecoration buildInputDecoration({
  required String title,
  required bool obscureText,
  required Function()? onPressed,
}) {
  return InputDecoration(
      label: Text(title),
      suffixIcon: onPressed != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.darkBrown,
                ),
                onPressed: onPressed,
              ),
            )
          : null);
}
