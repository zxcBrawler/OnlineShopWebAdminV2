import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_size_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_event.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class AddSizeDialog extends StatefulWidget {
  const AddSizeDialog({super.key});

  @override
  State<AddSizeDialog> createState() => _AddSizeDialogState();
}

class _AddSizeDialogState extends State<AddSizeDialog> {
  late final Map<String, TextEditingController> controllers;

  final SizeDTO newSize = SizeDTO();
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override

  /// Builds the widget representing the dialog for adding a new size.
  ///
  /// This method returns a [Dialog] widget that contains a [Column]
  /// with the necessary widgets for adding a new size. It includes a
  /// [BasicText] widget for the title, a loop that generates [BasicTextField]
  /// widgets for each field in the [controllers] map, and a [Padding] widget
  /// that contains an [ElevatedButton] widget for adding the size.
  ///
  /// The [Dialog] widget is the root of the returned widget tree.
  @override
  Widget build(BuildContext context) {
    if (isInitialized == false) {
      controllers = {
        S.of(context).sizeName: TextEditingController(text: ''),
      };
      isInitialized = true;
    }

    return Dialog(
      // The root of the widget tree
      child: Column(
        // The column widget that contains all the child widgets
        children: [
          // The widget for displaying the title
          BasicText(
            title: S.of(context).addNewSize,
          ),
          // Loop that generates widgets for each field
          for (var field in controllers.keys)
            BasicTextField(
              // The title of the field
              title: field,
              // The controller for the field
              controller: Methods.getControllerForField(controllers, field),
              // The field is enabled for editing
              isEnabled: true,
            ),
          Padding(
            // The padding around the button
            padding: const EdgeInsets.all(8.0),
            // The button for adding the size
            child: ElevatedButton(
              // The function to be called when the button is pressed
              onPressed: () async {
                addSize();
              },
              // The style of the button
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              // The text to be displayed on the button
              child: const BaseButtonText(title: "add new size"),
            ),
          )
        ],
      ),
    );
  }

  /// Adds the new size to the database.
  ///
  /// This function retrieves the text from the 'size name' field,
  /// adds the new size to the database using the [RemoteSizeBloc],
  /// waits for 1 second, and then pops the current route and navigates
  /// to the "All Sizes" screen.
  ///
  /// Parameters:
  /// None
  ///
  /// Returns:
  /// Future<void>
  Future<void> addSize() async {
    // Retrieve the text from the 'size name' field
    newSize.nameSize = controllers[S.of(context).sizeName]!.text;

    // Add the new size to the database using the [RemoteSizeBloc]
    service<RemoteSizeBloc>().add(AddSize(size: newSize));

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Pop the current route and navigate to the "All Sizes" screen
    router.pop();
    router.push(Pages.adminAllSizes.screenPath);
  }
}
