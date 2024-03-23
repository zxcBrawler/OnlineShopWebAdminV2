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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
      child: TextField(
        key: widget.key,
        enabled: widget.isEnabled,
        controller: widget.controller,
        style: GoogleFonts.hammersmithOne(textStyle: basicTextFieldStyle()),
        obscureText: widget.title == "password" && _obscureText,
        decoration: InputDecoration(
          labelText: widget.title,
          labelStyle: basicTextFieldStyle(),
          suffixIcon: widget.title == "password"
              ? Padding(
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
                )
              : widget.title == "shop address"
                  ? IconButton(
                      icon: Icon(
                        Icons.find_in_page,
                        color: AppColors.darkBrown,
                      ),
                      onPressed: widget.findAddress,
                    )
                  : null,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
