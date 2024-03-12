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

class AddSizeDialog extends StatefulWidget {
  const AddSizeDialog({super.key});

  @override
  State<AddSizeDialog> createState() => _AddSizeDialogState();
}

class _AddSizeDialogState extends State<AddSizeDialog> {
  late final Map<String, TextEditingController> controllers;

  final SizeDTO newSize = SizeDTO();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = {
      'size name': TextEditingController(text: ''),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          const BasicText(
            title: "add new size",
          ),
          for (var field in controllers.keys)
            BasicTextField(
              title: field,
              controller: Methods.getControllerForField(controllers, field),
              isEnabled: true,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                addSize();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const BaseButtonText(title: "add new size"),
            ),
          )
        ],
      ),
    );
  }

  void addSize() async {
    newSize.nameSize = controllers['size name']!.text;

    service<RemoteSizeBloc>().add(AddSize(size: newSize));
    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    router.push(Pages.adminAllSizes.screenPath);
  }
}
