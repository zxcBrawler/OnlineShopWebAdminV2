import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/widget/text/auth_button_text.dart';

class SizesContainer extends StatelessWidget {
  final String title;
  const SizesContainer({super.key, required this.title});

  @override

  /// Builds a widget that displays a container with a title in the center.
  ///
  /// The container has a specific width and a decoration with a brown color and
  /// a circular border radius. The title is displayed in the center of the
  /// container using the [AuthButtonText] widget.
  ///
  /// Parameters:
  /// - [context]: The build context.
  ///
  /// Returns:
  /// - A widget that displays the container with the title.
  @override
  Widget build(BuildContext context) {
    // The container that holds the title.
    return Container(
      // The width of the container.
      width: 100,
      // The decoration of the container.
      decoration: BoxDecoration(
        // The color of the container.
        color: AppColors.darkBrown,
        // The border radius of the container.
        borderRadius: BorderRadius.circular(30),
      ),
      // The child of the container.
      child: Center(
        // The child widget that displays the title.
        child: AuthButtonText(
          // The title to be displayed.
          title: title,
        ),
      ),
    );
  }
}
