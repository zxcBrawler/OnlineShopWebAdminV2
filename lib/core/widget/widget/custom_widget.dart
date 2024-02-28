import 'package:flutter/material.dart';

// A widget that displays a child widget based on the current location in the app
class CustomWidget extends StatefulWidget {
  // The initial location parameter for the widget
  final String initialLocation;

  // The child widget to be displayed
  final Widget child;

  const CustomWidget({
    super.key,
    required this.initialLocation,
    required this.child,
  });

  @override
  CustomWidgetState createState() => CustomWidgetState();
}

class CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
