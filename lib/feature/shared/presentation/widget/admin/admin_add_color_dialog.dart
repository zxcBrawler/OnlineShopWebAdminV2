import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_color_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_event.dart';

class AddColorDialog extends StatefulWidget {
  const AddColorDialog({super.key});

  @override
  State<AddColorDialog> createState() => _AddColorDialogState();
}

class _AddColorDialogState extends State<AddColorDialog> {
  late final Map<String, TextEditingController> controllers;
  Color currentColor = Colors.blue;

  final ColorDTO newColor = ColorDTO();

  @override
  void initState() {
    super.initState();
    controllers = {
      'color name': TextEditingController(text: ''),
    };
  }

  @override

  /// Builds the add color dialog widget.
  ///
  /// The [context] parameter is the build context of the widget.
  /// Returns a widget representing the add color dialog.
  Widget build(BuildContext context) {
    // Builds the add color dialog widget.
    return Dialog(
      // The dialog widget.
      child: SingleChildScrollView(
        // The scrollable widget containing the dialog content.
        child: Column(
          // The column widget containing the dialog content.
          children: [
            // The basic text widget displaying the title "add new color".
            const BasicText(
              title: "add new color",
            ),
            // Iterate over the controllers map and build the basic text field
            // widget for each field.
            for (var field in controllers.keys)
              BasicTextField(
                title: field,
                controller: Methods.getControllerForField(controllers, field),
                isEnabled: true,
              ),
            // The basic text widget displaying the title "choose color".
            const BasicText(
              title: "choose color",
            ),
            // The sized box widget containing the color picker widget.
            SizedBox(
              // The height and width of the color picker.
              height: 400,
              width: 650,
              // The color picker widget.
              child: ColorPicker(
                // The initial color of the picker.
                pickerColor: currentColor,
                // The callback function called when the color is changed.
                onColorChanged: changeColor,
                // The height of the picker area as a percentage of the widget height.
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            // The padding widget containing the add color button.
            Padding(
              padding: const EdgeInsets.all(8.0),
              // The elevated button widget for adding the color.
              child: ElevatedButton(
                // The callback function called when the button is pressed.
                onPressed: () async {
                  addColor();
                },
                // The style of the button.
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // The base button text widget displaying the title "add new color".
                child: const BaseButtonText(title: "add new color"),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Converts the given color integer to a hexadecimal string representation.
  ///
  /// The [color] parameter represents the integer value of the color.
  /// Returns a string in the format '#RRGGBB', where each letter represents
  /// a hexadecimal digit of the color.
  String convertColorToHex(int color) {
    // Convert the color integer to a hexadecimal string representation.
    // The substring(2) is used to remove the leading '0x' from the string.
    return '#${color.toRadixString(16).substring(2)}';
  }

  /// Updates the state of the widget with the new color selected by the user.
  ///
  /// The [color] parameter represents the new color selected by the user.
  /// This function is called whenever the user changes the color picker.
  void changeColor(Color color) {
    // Update the state of the widget with the new color.
    // This is done by calling setState and passing a function that updates
    // the currentColor variable with the new color value.
    setState(() {
      currentColor = color;
    });
  }

  /// Adds the color selected by the user to the database.
  ///
  /// This function is called when the user confirms the addition of a new color.
  /// It performs the following steps:
  /// 1. Retrieves the text entered by the user for the color name.
  /// 2. Converts the selected color to a hexadecimal string representation.
  /// 3. Adds the new color to the database using the [RemoteColorBloc].
  /// 4. Waits for 1 second.
  /// 5. Pops the current route and navigates to the "All Colors" screen.
  void addColor() async {
    // Retrieves the text entered by the user for the color name.
    newColor.nameColor = controllers['color name']!.text;

    // Converts the selected color to a hexadecimal string representation.
    newColor.hex = convertColorToHex(currentColor.value);

    // Adds the new color to the database using the [RemoteColorBloc].
    service<RemoteColorBloc>().add(AddColor(color: newColor));

    // Waits for 1 second.
    await Future.delayed(const Duration(seconds: 1));

    // Pops the current route and navigates to the "All Colors" screen.
    router.pop();
    router.push(Pages.adminAllColors.screenPath);
  }
}
