import 'package:flutter/material.dart';

// Responsive class for handling responsiveness of the app in different screen sizes
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width >= 800) {
      return desktop;
    } else {
      return mobile;
    }
  }
}
