import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';

class BasicTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isEnabled;
  final Function(void)? onChanged;
  final Function()? findAddress;
  const BasicTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.isEnabled,
    this.onChanged,
    this.findAddress,
  });

  @override
  State<BasicTextField> createState() => BasicTextFieldState();
}

class BasicTextFieldState extends State<BasicTextField> {
  bool _obscureText = true;

  @override

  /// Builds the text field widget.
  ///
  /// This method builds a text field widget with the provided properties.
  /// It wraps the text field with padding, applies style to the text field,
  /// and adds suffix icons based on the title.
  ///
  /// Parameters:
  /// - [context]: The build context of the widget.
  ///
  /// Returns:
  /// - A widget representing the built text field.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
      child: TextField(
        key: widget.key,
        enabled: widget.isEnabled,
        controller: widget.controller,
        // Apply text style to the text field
        style: GoogleFonts.hammersmithOne(textStyle: basicTextFieldStyle()),
        // Obscure the text if the title is "password" and _obscureText is true
        obscureText: widget.title == "password" && _obscureText,
        // Add decoration to the text field
        decoration: InputDecoration(
          labelText: widget.title,
          labelStyle: basicTextFieldStyle(),
          // Add suffix icon based on the title
          suffixIcon: _buildSuffixIcon(widget.title),
        ),
        // Call onChanged callback when the text field value is changed
        onChanged: widget.onChanged,
      ),
    );
  }

  /// Builds the suffix icon based on the title.
  ///
  /// Depending on the title, it returns an icon button widget with an icon
  /// for password visibility toggle, or a find in page icon button for shop
  /// address. It also calls the provided callback functions.
  ///
  /// Parameters:
  /// - `title`: The title of the text field.
  ///
  /// Returns:
  /// - A widget representing the built suffix icon.
  Widget? _buildSuffixIcon(String title) {
    if (title == "password") {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.darkBrown,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      );
    }
    if (title == "shop address") {
      return IconButton(
        icon: Icon(
          Icons.find_in_page,
          color: AppColors.darkBrown,
        ),
        onPressed: widget.findAddress,
      );
    }
    return null;
  }
}
