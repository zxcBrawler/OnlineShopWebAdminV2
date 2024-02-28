import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_input_decoration.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield_style.dart';

class BasicTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isEnabled;
  const BasicTextField(
      {super.key,
      required this.title,
      required this.controller,
      required this.isEnabled});

  @override
  State<BasicTextField> createState() => BasicTextFieldState();
}

class BasicTextFieldState extends State<BasicTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 8, bottom: 8, left: 100, right: 100),
        child: widget.title != "password"
            ? TextField(
                enabled: widget.isEnabled,
                controller: widget.controller,
                style: GoogleFonts.hammersmithOne(
                    textStyle: basicTextFieldStyle()),
                obscureText: false,
                decoration: buildInputDecoration(
                    title: widget.title, obscureText: false, onPressed: null),
              )
            : TextField(
                enabled: widget.isEnabled,
                controller: widget.controller,
                style: GoogleFonts.hammersmithOne(
                    textStyle: basicTextFieldStyle()),
                obscureText: _obscureText,
                decoration: buildInputDecoration(
                    title: widget.title,
                    obscureText: _obscureText,
                    onPressed: _togglePasswordVisibility),
              ));
  }
}
