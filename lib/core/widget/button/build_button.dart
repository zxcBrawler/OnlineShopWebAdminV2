import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';

/// Builds a button widget with the given [title], [backgroundColor], and [onPressed] callback.
///
/// The button has a padding of 8 on all sides and is an elevated button with a rounded rectangle shape.
/// The [title] is displayed using the [BaseButtonText] widget.
///
/// Parameters:
/// - `title`: The text to be displayed on the button.
/// - `backgroundColor`: The background color of the button.
/// - `onPressed`: The callback function that is called when the button is pressed.
Widget buildButton(
    String title, Color backgroundColor, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(8.0), // Adds padding of 8 on all sides
    child: ElevatedButton(
      onPressed: onPressed, // Calls the provided callback when pressed
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Sets the background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Sets the border radius
        ),
      ),
      child: BaseButtonText(title: title), // Displays the title on the button
    ),
  );
}
