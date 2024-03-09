import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final Color color;
  const ColorContainer({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
