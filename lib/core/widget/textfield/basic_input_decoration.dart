import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';

/// Builds an [InputDecoration] widget with the provided parameters.
///
/// The [title] parameter is the label text for the input field.
/// The [obscureText] parameter determines whether the input text should be obscured.
/// The [onPressed] parameter is an optional callback function for the suffix icon.
///
/// Returns an [InputDecoration] widget.
InputDecoration buildInputDecoration({
  required String title,
  required bool obscureText,
  required Function()? onPressed,
}) {
  return InputDecoration(
    label: Text(title), // Sets the label text for the input field
    suffixIcon: onPressed != null
        ? Padding(
            padding:
                const EdgeInsets.all(8.0), // Adds padding to the suffix icon
            child: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColors.darkBrown, // Sets the color of the suffix icon
              ),
              onPressed:
                  onPressed, // Sets the callback function for the suffix icon
            ),
          )
        : null, // Sets the suffix icon to null if onPressed is null
  );
}
