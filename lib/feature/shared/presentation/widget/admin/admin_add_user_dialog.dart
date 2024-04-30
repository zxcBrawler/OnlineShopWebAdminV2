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
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/generated/l10n.dart';

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
  int? selectedShopAddressIndex = 0;
  bool isInitialized = false;

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
    if (isInitialized == false) {
      controllers = {
        // Email text field controller.
        S.of(context).email: TextEditingController(text: ''),
        // Password text field controller.
        S.of(context).password: TextEditingController(text: ''),
        // Phone number text field controller.
        S.of(context).phoneNumber: TextEditingController(text: ''),
        // Username text field controller.
        S.of(context).username: TextEditingController(text: ''),
        // Employee number text field controller.
        S.of(context).employeeNumber: TextEditingController(text: ''),
      };
      isInitialized = true;
    }
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
                    BasicText(
                      title: S.of(context).addNewUser,
                    ),
                    BasicDropdown(
                      listTitle: S.of(context).chooseRole,
                      dropdownData: state.roles!
                          .map((e) => e.roleName!)
                          .where((element) => element != "user")
                          .toList(),
                      selectedIndex: selectedRoleIndex!,
                      onIndexChanged: (value) {
                        setState(() {
                          selectedRoleIndex = value;
                        });
                      },
                      isColorDropdown: false,
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
                                listTitle: S.of(context).chooseGender,
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
                            case RemoteGenderError():
                              return Text(S.of(context).error);
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    BasicText(title: S.of(context).enterUserDetails),
                    for (var field in controllers.keys)
                      BasicTextField(
                        title: field,
                        controller:
                            Methods.getControllerForField(controllers, field),
                        isEnabled: true,
                      ),
                    BlocProvider<RemoteShopAddressesBloc>(
                      create: (context) =>
                          service()..add(const GetShopAddresses()),
                      child: BlocBuilder<RemoteShopAddressesBloc,
                          RemoteShopAddressState>(builder: (_, state) {
                        switch (state) {
                          case RemoteShopAddressLoading():
                            return const SizedBox();
                          case RemoteShopAddressDone():
                            return BasicDropdown(
                              listTitle: S.of(context).chooseShopAddress,
                              dropdownData: state.shopAddresses!
                                  .map((e) => e.shopAddressDirection!)
                                  .toList(),
                              selectedIndex: selectedShopAddressIndex!,
                              onIndexChanged: (value) {
                                setState(() {
                                  selectedShopAddressIndex = value;
                                });
                              },
                              isColorDropdown: false,
                            );
                          case RemoteShopAddressError():
                            return Text(S.of(context).error);
                        }
                        return const SizedBox();
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          newUser.email =
                              controllers[S.of(context).email]!.text;
                          newUser.passwordHash =
                              controllers[S.of(context).password]!.text;
                          newUser.phoneNumber =
                              controllers[S.of(context).phoneNumber]!.text;
                          newUser.username =
                              controllers[S.of(context).username]!.text;
                          newUser.employeeNumber =
                              controllers[S.of(context).employeeNumber]!.text;
                          newUser.role = selectedRoleIndex! + 1;
                          newUser.gender = selectedGenderIndex! + 1;
                          newUser.shopAddressId = selectedShopAddressIndex! + 1;
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
                        child: BaseButtonText(title: S.of(context).addNewUser),
                      ),
                    )
                  ],
                );
              case RemoteRoleError():
                return Text(S.of(context).error);
            }
            return const SizedBox();
          },
        ),
      )),
    );
  }
}
