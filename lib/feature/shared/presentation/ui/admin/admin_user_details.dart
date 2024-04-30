import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/button/build_button.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
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
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_user_addresses_table.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_user_orders_table.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class AdminUserDetails extends StatefulWidget {
  final UserEntity? user;
  const AdminUserDetails({super.key, this.user});

  @override
  State<AdminUserDetails> createState() => _AdminUserDetailsState();
}

class _AdminUserDetailsState extends State<AdminUserDetails> {
  // Controllers for handling user input
  late Map<String, TextEditingController> controllers;
  // DTO for storing updated user information
  final UserDTO updatedUser = UserDTO();

  // Selected indices for role and gender dropdowns
  late int? selectedRoleIndex;
  late int? selectedGenderIndex;

  @override

  /// Initializes the state of the [_AdminUserDetailsState] widget.
  ///
  /// This method is called when the widget is inserted into the tree. It
  /// initializes the state of the widget by setting the values of the
  /// controllers with the user data and setting the initial selected indices
  /// for the role and gender dropdowns.
  @override
  void initState() {
    // Call the parent's initState method
    super.initState();
  }

  @override

  /// Builds the widget tree for the AdminUserDetails screen.
  ///
  /// This method builds the widget tree for the AdminUserDetails screen,
  /// which displays details about a specific user. It includes various
  /// text fields for displaying information about the user, such as the
  /// email, phone number, username, and employee number, if user role is "user".
  /// It also includes a dropdown menus for selecting the role and gender of user, which can be changed.
  /// Also, if user role is "user", it includes a various widget to display the user's orders,  user's payment info
  /// and user's addresses in a table.
  /// Finally, it includes a buttons for editing user gender and role
  /// and deleting the user (which is not allowed if user role is "user").
  Widget build(BuildContext context) {
    // Check if the screen size is mobile
    final isMobile = Responsive.isMobile(context);
    controllers = {
      S.of(context).email: TextEditingController(),
      S.of(context).phoneNumber: TextEditingController(),
      S.of(context).username: TextEditingController(),
    };
    final user = widget.user!;
    controllers[S.of(context).email]!.text = user.email!;
    controllers[S.of(context).phoneNumber]!.text = user.phoneNumber!;
    controllers[S.of(context).username]!.text = user.username!;

    // If user role is not "user", add "employee number" controller and set its value
    if (widget.user!.role!.roleName != "user") {
      controllers.addEntries([
        MapEntry(S.of(context).employeeNumber, TextEditingController()),
      ]);
      controllers[S.of(context).employeeNumber]!.text = user.employeeNumber!;
    }

    // Set initial selected indices
    selectedRoleIndex = user.role!.id! - 1;
    selectedGenderIndex = user.gender!.id! - 1;

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
                  // Back button
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
                  // Header title
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: HeaderText(
                            textSize: isMobile ? 35 : 45,
                            title: S.of(context).userDetails,
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Text fields for user input
                        for (var field in controllers.keys)
                          BasicTextField(
                            title: field,
                            controller: Methods.getControllerForField(
                                controllers, field),
                            isEnabled: false,
                          ),
                        // Dropdowns for role and gender
                        if (!isMobile) ...[
                          Row(
                            children: [
                              // Role dropdown
                              Expanded(
                                child: BlocProvider<RemoteRoleBloc>(
                                  create: (context) =>
                                      service()..add(const GetRoles()),
                                  child: BlocBuilder<RemoteRoleBloc,
                                      RemoteRoleState>(
                                    builder: (context, state) {
                                      if (state is RemoteRoleDone) {
                                        return BasicDropdown(
                                          listTitle: S.of(context).role,
                                          dropdownData: state.roles!
                                              .map((e) => e.roleName!)
                                              .toList(),
                                          selectedIndex: selectedRoleIndex!,
                                          onIndexChanged: (value) {
                                            setState(() {
                                              selectedRoleIndex = value;
                                            });
                                          },
                                          isColorDropdown: false,
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                              // Gender dropdown
                              Expanded(
                                child: BlocProvider<RemoteGendersBloc>(
                                  create: (context) =>
                                      service()..add(const GetGenders()),
                                  child: BlocBuilder<RemoteGendersBloc,
                                      RemoteGenderState>(
                                    builder: (_, state) {
                                      if (state is RemoteGenderDone) {
                                        return BasicDropdown(
                                          listTitle: S.of(context).gender,
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
                                          isColorDropdown: false,
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
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
                                          listTitle: S.of(context).role,
                                          dropdownData: state.roles!
                                              .map((e) => e.roleName!)
                                              .toList(),
                                          selectedIndex: selectedRoleIndex!,
                                          onIndexChanged: (value) {
                                            setState(() {
                                              selectedRoleIndex = value;
                                            });
                                          },
                                          isColorDropdown: false,
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Gender dropdown
                          Row(
                            children: [
                              Expanded(
                                child: BlocProvider<RemoteGendersBloc>(
                                  create: (context) =>
                                      service()..add(const GetGenders()),
                                  child: BlocBuilder<RemoteGendersBloc,
                                      RemoteGenderState>(
                                    builder: (_, state) {
                                      if (state is RemoteGenderDone) {
                                        return BasicDropdown(
                                          listTitle: S.of(context).gender,
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
                                          isColorDropdown: false,
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
              // Additional sections if user role is "user"
              if (widget.user!.role!.roleName == "user") ...[
                // User orders section
                HeaderText(
                  textSize: isMobile ? 35 : 45,
                  title: S.of(context).userOrders,
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
                // User payment info section

                // User addresses section
                HeaderText(
                  textSize: isMobile ? 35 : 45,
                  title: S.of(context).userAddresses,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BasicContainer(
                    child: Column(
                      children: [
                        UserAddressesTable(
                          user: widget.user!,
                        )
                      ],
                    ),
                  ),
                ),
              ],
              // Buttons for editing and deleting user
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Edit button
                  buildButton(
                      S.of(context).edit, AppColors.darkBrown, _editUserInfo),
                  // Delete button
                  widget.user!.role!.roleName != "user"
                      ? buildButton(
                          S.of(context).delete, AppColors.red, _deleteUser)
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle updating user information
  /// Function to handle updating user information.
  ///
  /// This function retrieves the user information from the controllers and
  /// updates the [updatedUser] object with the new information. It then sends
  /// an [UpdateUser] event to the [RemoteUserBloc] with the updated user.
  /// After the event is processed, the function pops the current route and
  /// navigates to the admin all users page.
  void _editUserInfo() async {
    // Update the user info in the [updatedUser] object
    updatedUser.id = widget.user!.id!;
    updatedUser.email = controllers[S.of(context).email]!.text;
    updatedUser.username = controllers[S.of(context).username]!.text;
    updatedUser.phoneNumber = controllers[S.of(context).phoneNumber]!.text;
    if (widget.user!.role!.roleName != "user") {
      updatedUser.employeeNumber =
          controllers[S.of(context).employeeNumber]!.text;
    }
    updatedUser.gender = selectedGenderIndex! + 1;
    updatedUser.role = selectedRoleIndex! + 1;

    // Send the updated user to the RemoteUserBloc
    service<RemoteUserBloc>().add(UpdateUser(user: updatedUser));

    // Wait for 1 second and then pop the current route and navigate to the
    // admin all users page.
    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    router.push(
      Pages.adminAllUsers.screenPath,
    );
  }

  // Function to handle deleting user

  /// Deletes a user.
  ///
  /// This function handles the deletion of a user. If the user is not a
  /// 'buyer', it sends a [DeleteUser] event to the [RemoteUserBloc] with the
  /// user's id and then pops the current route and navigates to the admin
  /// all users page. If the user is a 'buyer', it simply pops the current
  /// route.
  ///
  /// This function has no parameters.
  ///
  /// This function does not return anything.
  void _deleteUser() async {
    // If the user is not a 'buyer'
    if (widget.user!.role!.roleName! != "user") {
      // Send a DeleteUser event to the RemoteUserBloc
      service<RemoteUserBloc>().add(DeleteUser(id: widget.user!.id!));

      // Wait for 1 second and then pop the current route and navigate to the
      // admin all users page.
      await Future.delayed(const Duration(seconds: 1));
      router.pop();
      router.push(
        Pages.adminAllUsers.screenPath,
      );
    }
    // If the user is a 'buyer'
    else {
      // Simply pop the current route.
      router.pop();
    }
  }
}
