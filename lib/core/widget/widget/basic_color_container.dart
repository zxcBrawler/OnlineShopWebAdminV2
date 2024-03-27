import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final Color color;
  const ColorContainer({super.key, required this.color});

  @override

  /// A [StatelessWidget] that represents a container with a specific color.
  ///
  /// This widget is a [Container] with a circular shape and the specified [color].
  /// It is used to display a colored box with a size of 50x50 pixels.
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
