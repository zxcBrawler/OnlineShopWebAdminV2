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
  _AdminUserDetailsState createState() => _AdminUserDetailsState();
}

class _AdminUserDetailsState extends State<AdminUserDetails> {
  // Controllers for handling user input
  late final TextEditingController emailController;
  late final TextEditingController phoneNumController;
  late final TextEditingController usernameController;
  late final TextEditingController employeeNumberController;

  // DTO for storing updated user information
  final UserDTO updatedUser = UserDTO();

  // Selected indices for role and gender dropdowns
  late int? selectedRoleIndex;
  late int? selectedGenderIndex;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with user data
    final user = widget.user!;
    emailController = TextEditingController(text: user.email);
    phoneNumController = TextEditingController(text: user.phoneNumber);
    usernameController = TextEditingController(text: user.username);
    employeeNumberController = TextEditingController(text: user.employeeNumber);

    // Set initial selected indices
    selectedRoleIndex = user.role!.id! - 1;
    selectedGenderIndex = user.gender!.id! - 1;
  }

  @override
  Widget build(BuildContext context) {
    // Check if the screen size is mobile
    final isMobile = Responsive.isMobile(context);

    // Determine which fields to display based on user role
    final fields = (widget.user!.role!.roleName != "user")
        ? ["username", "phone num", "email", "employee number"]
        : ["username", "phone num", "email"];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header and back button
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
              // User input fields and dropdowns
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.group, size: 500, color: AppColors.darkBrown),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Text fields for user input
                        for (var field in fields)
                          BasicTextField(
                            title: field,
                            controller: _getControllerForField(field),
                            isEnabled: field != "password",
                          ),
                        // Dropdowns for role and gender
                        Row(
                          children: [
                            Expanded(
                              child: BlocProvider<RemoteRoleBloc>(
                                create: (context) =>
                                    service()..add(const GetRoles()),
                                child: BlocBuilder<RemoteRoleBloc,
                                    RemoteRoleState>(
                                  builder: (context, state) {
                                    if (state is RemoteRoleDone) {
                                      return BasicDropdown(
                                        listTitle: "role",
                                        dropdownData: state.roles!
                                            .map((e) => e.roleName!)
                                            .toList(),
                                        selectedIndex: selectedRoleIndex!,
                                        onIndexChanged: (value) {
                                          setState(() {
                                            selectedRoleIndex = value;
                                          });
                                        },
                                      );
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
                                    if (state is RemoteGenderDone) {
                                      return BasicDropdown(
                                        listTitle: "gender",
                                        dropdownData: state.genders!
                                            .map((e) => e.nameCategory!)
                                            .toList()
                                            .reversed
                                            .toList(),
                                        selectedIndex: selectedGenderIndex!,
                                        onIndexChanged: (value) {
                                          setState(() {
                                            selectedGenderIndex = value;
                                          });
                                        },
                                      );
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
              // Additional sections if user role is "user"
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
              // Buttons for editing and deleting user
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
    );
  }

  // Function to handle updating user information
  void _editUserInfo() async {
    updatedUser.id = widget.user!.id!;
    updatedUser.email = emailController.text;
    updatedUser.username = usernameController.text;
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

  // Function to handle deleting user
  void _deleteUser() async {
    if (widget.user!.role!.roleName! != "user") {
      service<RemoteUserBloc>().add(DeleteUser(id: widget.user!.id!));
      await Future.delayed(const Duration(seconds: 1));
      router.pop();
      router.push(
        Pages.adminAllUsers.screenPath,
      );
    } else {
      //TODO: handle case when user wants to delete buyer (that's not allowed)
      router.pop();
    }
  }

  // Function to get the controller for a specific input field
  TextEditingController _getControllerForField(String field) {
    switch (field) {
      case "username":
        return usernameController;

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

  // Widget for building custom buttons
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
