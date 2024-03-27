import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';

class BasicContainer extends StatelessWidget {
  final Widget child;

  const BasicContainer({
    super.key,
    required this.child,
  });
  @override

  /// Builds the container widget.
  ///
  /// This method is responsible for building the container widget. It creates
  /// a container with a box decoration, including a box shadow, a white color,
  /// and a circular border radius. The [child] widget is added as a child to
  /// the container.
  ///
  /// Parameters:
  ///   - [context]: The build context of the widget.
  ///
  /// Returns:
  ///   - A widget representing the built container.
  @override
  Widget build(BuildContext context) {
    return Container(
      // Box decoration
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // Box shadow properties
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // Child widget
      child: child,
    );
  }
}
