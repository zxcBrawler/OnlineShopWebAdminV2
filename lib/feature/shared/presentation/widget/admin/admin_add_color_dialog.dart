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
    // TODO: implement initState
    super.initState();
    controllers = {
      'color name': TextEditingController(text: ''),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const BasicText(
              title: "add new color",
            ),
            for (var field in controllers.keys)
              BasicTextField(
                title: field,
                controller: Methods.getControllerForField(controllers, field),
                isEnabled: true,
              ),
            const BasicText(
              title: "choose color",
            ),
            SizedBox(
              height: 400,
              width: 650,
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  addColor();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBrown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const BaseButtonText(title: "add new color"),
              ),
            )
          ],
        ),
      ),
    );
  }

  String convertColorToHex(int color) {
    return '#${color.toRadixString(16).substring(2)}';
  }

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  void addColor() async {
    newColor.nameColor = controllers['color name']!.text;
    newColor.hex = convertColorToHex(currentColor.value);

    service<RemoteColorBloc>().add(AddColor(color: newColor));
    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    router.push(Pages.adminAllColors.screenPath);
  }
}
