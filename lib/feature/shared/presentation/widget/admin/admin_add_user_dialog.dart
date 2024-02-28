import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/role_entity.dart';
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
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final TextEditingController phoneNumController;
  late final TextEditingController usernameController;
  late final TextEditingController employeeNumberController;

  final UserDTO newUser = UserDTO();

  int? selectedRoleIndex = 0;
  int? selectedGenderIndex = 0;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController(text: "");
    passController = TextEditingController(text: "");
    phoneNumController = TextEditingController(text: "");
    usernameController = TextEditingController(text: "");
    employeeNumberController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const BasicText(
        title: "add new user",
      ),
      content: SingleChildScrollView(
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
                    ..._buildTextFieldsForRole(state.roles!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          newUser.email = emailController.text;
                          newUser.passwordHash = passController.text;
                          newUser.phoneNumber = phoneNumController.text;
                          newUser.username = usernameController.text;
                          newUser.employeeNumber =
                              employeeNumberController.text;
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

  TextEditingController _getControllerForField(String field) {
    switch (field) {
      case "username":
        return usernameController;
      case "password":
        return passController;
      case "phone num":
        return phoneNumController;

      case "email":
        return emailController;
      case "employee number":
        return employeeNumberController;

      default:
        throw Exception("Invalid field: $field");
    }
  }

  List<Widget> _buildTextFieldsForRole(List<RoleEntity> roles) {
    final List<String> fields = [
      "username",
      "password",
      "phone num",
      "email",
      "employee number"
    ];

    return fields.map((field) {
      return BasicTextField(
        title: field,
        controller: _getControllerForField(field),
        isEnabled: true,
      );
    }).toList();
  }
}
