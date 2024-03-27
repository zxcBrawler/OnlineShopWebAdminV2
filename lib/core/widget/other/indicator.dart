import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override

  /// Builds the indicator widget.
  ///
  /// This method returns a [Row] widget containing a [Container] for the
  /// color indicator and a [Text] widget for the text. The [Container] has a
  /// size specified by the [size] property and its decoration is determined by
  /// the [isSquare] and [color] properties. The [Text] widget displays the
  /// [text] property and has a font size of 16, bold font weight, and a color
  /// specified by the [textColor] property.
  ///
  /// Parameters:
  ///   - [context]: The build context of the widget.
  ///
  /// Returns:
  ///   - A [Row] widget representing the indicator.
  @override
  Widget build(BuildContext context) {
    return Row(
      // The row contains the color indicator and the text.
      children: <Widget>[
        Container(
          // The container represents the color indicator.
          width: size,
          height: size,
          decoration: BoxDecoration(
            // The shape of the container is determined by the isSquare property.
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            // The color of the container is specified by the color property.
            color: color,
          ),
        ),
        const SizedBox(
          // A spacing between the color indicator and the text.
          width: 4,
        ),
        Text(
          // The text widget displays the text property.
          text,
          style: TextStyle(
            // The font size of the text is 16.
            fontSize: 16,
            // The text has a bold font weight.
            fontWeight: FontWeight.bold,
            // The color of the text is specified by the textColor property.
            color: textColor,
          ),
        )
      ],
    );
  }
}
