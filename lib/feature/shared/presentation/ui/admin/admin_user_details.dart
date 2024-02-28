import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_edit_user_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_user_orders_table.dart';

class AdminUserDetails extends StatefulWidget {
  final UserEntity? user;
  const AdminUserDetails({super.key, this.user});

  @override
  State<AdminUserDetails> createState() => _AdminUserDetailsState();
}

class _AdminUserDetailsState extends State<AdminUserDetails> {
  late final TextEditingController emailController;
  late final TextEditingController passController;
  late final TextEditingController phoneNumController;
  late final TextEditingController usernameController;
  late final TextEditingController employeeNumberController;
  final UserDTO updatedUser = UserDTO();
  late int? selectedRoleIndex;
  late int? selectedGenderIndex;

  @override
  void initState() {
    super.initState();
    final user = widget.user!;
    emailController = TextEditingController(text: user.email);
    passController = TextEditingController(text: user.passwordHash);
    phoneNumController = TextEditingController(text: user.phoneNumber);
    usernameController = TextEditingController(text: user.username);
    employeeNumberController = TextEditingController(text: user.employeeNumber);

    selectedRoleIndex = user.role!.id! - 1;
    selectedGenderIndex = user.gender!.id! - 1;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final List<String> fields = (widget.user!.role!.roleName != "user")
        ? ["username", "password", "phone num", "email", "employee number"]
        : ["username", "password", "phone num", "email"];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.darkBrown,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: HeaderText(
                              textSize: isMobile ? 35 : 45,
                              title: 'user details',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.group, size: 500, color: AppColors.darkBrown),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (var field in fields)
                            BasicTextField(
                              title: field,
                              controller: _getControllerForField(field),
                              isEnabled: field != "password",
                            ),
                          Row(
                            children: [
                              Expanded(
                                child: BlocProvider<RemoteRoleBloc>(
                                  create: (context) =>
                                      service()..add(const GetRoles()),
                                  child: BlocBuilder<RemoteRoleBloc,
                                      RemoteRoleState>(
                                    builder: (context, state) {
                                      switch (state) {
                                        case RemoteRoleLoading():
                                          return const SizedBox();
                                        case RemoteRoleDone():
                                          return BasicDropdown(
                                            listTitle: "role",
                                            dropdownData: state.roles!
                                                .map((e) => e.roleName!)
                                                .toList(),
                                            selectedIndex: selectedRoleIndex!,
                                            onIndexChanged: (value) {
                                              selectedRoleIndex = value;
                                            },
                                          );
                                        case RemoteRoleError():
                                          return const Text("error");
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: BlocProvider<RemoteGendersBloc>(
                                  create: (context) =>
                                      service()..add(const GetGenders()),
                                  child: BlocBuilder<RemoteGendersBloc,
                                      RemoteGenderState>(
                                    builder: (_, state) {
                                      switch (state) {
                                        case RemoteGenderLoading():
                                          return const SizedBox();
                                        case RemoteGenderDone():
                                          return BasicDropdown(
                                            listTitle: "gender",
                                            dropdownData: state.genders!
                                                .map((e) => e.nameCategory!)
                                                .toList()
                                                .reversed
                                                .toList(),
                                            selectedIndex: selectedGenderIndex!,
                                            onIndexChanged: (value) {
                                              selectedGenderIndex = value;
                                            },
                                          );
                                        case RemoteGenderError():
                                          return const Text("error");
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if (widget.user!.role!.roleName == "user") ...[
                  HeaderText(
                    textSize: isMobile ? 35 : 45,
                    title: 'user orders',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          UserOrdersTable(user: widget.user!),
                        ],
                      ),
                    ),
                  ),
                  HeaderText(
                    textSize: isMobile ? 35 : 45,
                    title: 'user payment info',
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          BasicText(title: 'user payment info'),
                        ],
                      ),
                    ),
                  ),
                  HeaderText(
                    textSize: isMobile ? 35 : 45,
                    title: 'user addresses',
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BasicContainer(
                      child: Column(
                        children: [
                          BasicText(title: 'user addresses'),
                        ],
                      ),
                    ),
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildButton("Edit", AppColors.darkBrown, _editUserInfo),
                    _buildButton("Delete", AppColors.red, _deleteUser),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editUserInfo() async {
    updatedUser.id = widget.user!.id!;
    updatedUser.email = emailController.text;
    updatedUser.username = usernameController.text;
    updatedUser.passwordHash = passController.text;
    updatedUser.phoneNumber = phoneNumController.text;
    updatedUser.employeeNumber = employeeNumberController.text;
    updatedUser.gender = selectedGenderIndex! + 1;
    updatedUser.role = selectedRoleIndex! + 1;
    service<RemoteUserBloc>().add(UpdateUser(user: updatedUser));
    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    router.push(
      Pages.adminAllUsers.screenPath,
    );
  }

  void _deleteUser() async {
    //TODO: Add logic for deleting user
    service<RemoteUserBloc>().add(DeleteUser(id: widget.user!.id!));
    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    router.push(
      Pages.adminAllUsers.screenPath,
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

  Widget _buildButton(
      String title, Color backgroundColor, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: BaseButtonText(title: title),
      ),
    );
  }
}
