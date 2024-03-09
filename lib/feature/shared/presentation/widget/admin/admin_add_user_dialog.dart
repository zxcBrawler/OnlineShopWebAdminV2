import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  late final Map<String, TextEditingController> controllers;

  final UserDTO newUser = UserDTO();

  int? selectedRoleIndex = 0;
  int? selectedGenderIndex = 0;

  @override

  /// Initializes the state of the [_AddUserDialogState] class.
  ///
  /// This function is called immediately after the widget is inserted into the
  /// tree in a stateful widget, and in particular, it is called each time
  /// [State.setState] is called, unless [State.mounted] is false.
  ///
  /// In this function, a [Map] is initialized to hold [TextEditingController]
  /// objects for each of the text fields in the add user dialog. The keys of the
  /// map are the names of the text fields, and the values are the
  /// [TextEditingController] objects.
  @override
  void initState() {
    // Call the superclass's initState function.
    super.initState();

    // Initialize the controllers map.
    controllers = {
      // Email text field controller.
      'email': TextEditingController(text: ''),
      // Password text field controller.
      'pass': TextEditingController(text: ''),
      // Phone number text field controller.
      'phoneNum': TextEditingController(text: ''),
      // Username text field controller.
      'username': TextEditingController(text: ''),
      // Employee number text field controller.
      'employeeNumber': TextEditingController(text: ''),
    };
  }

  @override

  /// Builds the UI for the add user dialog.
  ///
  /// This function returns a [Dialog] widget with a [SingleChildScrollView]
  /// containing a [BlocProvider] and a [BlocBuilder] widgets. The [BlocProvider]
  /// widget is used to create a [RemoteRoleBloc] and the [BlocBuilder] widget
  /// is used to listen to the state of the [RemoteRoleBloc]. Depending on the
  /// state, different UI elements are rendered.
  ///
  /// The [Dialog] widget is the root widget and contains a scrollable
  /// [SingleChildScrollView]. Inside the scroll view, there is a [BlocProvider]
  /// widget that creates a [RemoteRoleBloc] and adds a [GetRoles] event to
  /// it. Inside the [BlocProvider], there is a [BlocBuilder] widget that listens
  /// to the state of the [RemoteRoleBloc]. Depending on the state, different
  /// UI elements are rendered.
  ///
  /// The UI elements rendered by the [BlocBuilder] widget include a
  /// [BasicText] widget for the title, a [BasicDropdown] widget for the role
  /// selection, a [BlocProvider] widget for the gender selection, and a list
  /// of [BasicInput] widgets for the user details. At the bottom, there is an
  /// [ElevatedButton] widget that adds a new user when pressed.
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
          child: BlocProvider<RemoteRoleBloc>(
        create: (context) => service()..add(const GetRoles()),
        child: BlocBuilder<RemoteRoleBloc, RemoteRoleState>(
          builder: (context, state) {
            switch (state) {
              case RemoteRoleLoading():
                return const SizedBox();
              case RemoteRoleDone():
                return Column(
                  children: [
                    const BasicText(
                      title: "add new user",
                    ),
                    BasicDropdown(
                      listTitle: "choose role",
                      dropdownData: state.roles!
                          .map((e) => e.roleName!)
                          .where((element) => element != "user")
                          .toList(),
                      selectedIndex: selectedRoleIndex!,
                      onIndexChanged: (value) {
                        selectedRoleIndex = value;
                      },
                    ),
                    BlocProvider<RemoteGendersBloc>(
                      create: (context) => service()..add(const GetGenders()),
                      child: BlocBuilder<RemoteGendersBloc, RemoteGenderState>(
                        builder: (_, state) {
                          switch (state) {
                            case RemoteGenderLoading():
                              return const SizedBox();
                            case RemoteGenderDone():
                              return BasicDropdown(
                                  listTitle: "choose gender",
                                  dropdownData: state.genders!
                                      .map((e) => e.nameCategory!)
                                      .toList()
                                      .reversed
                                      .toList(),
                                  selectedIndex: selectedGenderIndex!,
                                  onIndexChanged: (value) {
                                    selectedGenderIndex = value;
                                  });
                            case RemoteGenderError():
                              return const Text("error");
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    const BasicText(title: "enter user details"),
                    for (var field in controllers.keys)
                      BasicTextField(
                        title: field,
                        controller:
                            Methods.getControllerForField(controllers, field),
                        isEnabled: true,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          newUser.email = controllers['email']!.text;
                          newUser.passwordHash = controllers['pass']!.text;
                          newUser.phoneNumber = controllers['phoneNum']!.text;
                          newUser.username = controllers['username']!.text;
                          newUser.employeeNumber =
                              controllers['employeeNumber']!.text;
                          newUser.role = selectedRoleIndex! + 1;
                          newUser.gender = selectedGenderIndex! + 1;
                          service<RemoteUserBloc>().add(AddUser(user: newUser));

                          await Future.delayed(const Duration(seconds: 1));
                          router.pop();
                          router.push(
                            Pages.adminAllUsers.screenPath,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkBrown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const BaseButtonText(title: "add new user"),
                      ),
                    )
                  ],
                );
              case RemoteRoleError():
                return const Text("error");
            }
            return const SizedBox();
          },
        ),
      )),
    );
  }
}
