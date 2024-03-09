import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';

Widget buildButton(
    String title, Color backgroundColor, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: BaseButtonText(title: title),
    ),
  );
}
