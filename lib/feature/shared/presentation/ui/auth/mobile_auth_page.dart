import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/auth_button_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/auth/auth_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/auth/auth_state.dart';

class MobileAuthPage extends StatefulWidget {
  const MobileAuthPage({super.key});

  @override
  State<MobileAuthPage> createState() => _MobileAuthPageState();
}

class _MobileAuthPageState extends State<MobileAuthPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial values of the text fields to dummy values for testing purposes.
    usernameController.text = "zxcBrawler4";
    passController.text = "zxc1234";
  }

  @override

  /// Builds the user interface widget tree for the mobile authentication page.
  ///
  /// If the device is a mobile device, a [SizedBox] widget is returned.
  /// If the device is not a mobile device, a [BlocProvider] widget is returned.
  /// The [BlocProvider] widget wraps a [Row] widget with three [Expanded] widgets.
  /// The first and third [Expanded] widgets are empty [Container] widgets.
  /// The second [Expanded] widget contains a [Padding] widget with a [Column] widget.
  /// The [Column] widget has two [BasicTextField] widgets for the username and password input fields.
  /// It also contains a [Padding] widget with a [Row] widget.
  /// The [Row] widget contains an [ElevatedButton] widget for the authentication button.
  Widget build(BuildContext context) {
    // Check if the device is a mobile device.
    if (Responsive.isMobile(context)) {
      // TODO: Implement authentication page for mobile devices.
      return const SizedBox();
    } else {
      // If the device is not a mobile device, build the authentication page.
      return BlocProvider(
        // Create the authentication bloc.
        create: (context) => service<AuthBloc>(),
        // The authentication page is a row with three expandable widgets.
        child: Row(
          children: [
            // Empty container widget for spacing.
            Expanded(flex: 1, child: Container()),
            // Expandable widget that contains the authentication form.
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  // Align the form at the center of the widget.
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image widget for the application logo.
                    Center(
                        child: SizedBox(
                            width: 150,
                            height: 150,
                            child:
                                Image.asset("assets/xc-logo-transparent.png"))),
                    // Text field widget for the username input.
                    BasicTextField(
                      key: const Key("authUsernameInput"),
                      title: "username",
                      controller: usernameController,
                      isEnabled: true,
                    ),
                    // Text field widget for the password input.
                    BasicTextField(
                      key: const Key("authPasswordInput"),
                      title: "password",
                      controller: passController,
                      isEnabled: true,
                    ),
                    // Padding widget with a row widget for the authentication button.
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                      child: Row(
                        children: [
                          // Expandable widget that contains the authentication button.
                          Expanded(
                            child: ElevatedButton(
                              key: const Key("authButton"),
                              onPressed: () async {
                                // Call the login and navigate function when the button is pressed.
                                await _loginAndNavigate();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.darkBrown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const AuthButtonText(
                                title: "auth",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Empty container widget for spacing.
            Expanded(flex: 1, child: Container()),
          ],
        ),
      );
    }
  }

  @override

  /// Dispose method to clean up resources when the widget is removed from the tree.
  ///
  /// This method is called when the widget is removed from the widget tree.
  /// It disposes the usernameController, passController, and then calls
  /// the super.dispose() method to clean up resources used by the parent class.

  void dispose() {
    // Dispose the usernameController to release its resources.
    usernameController.dispose();

    // Dispose the passController to release its resources.
    passController.dispose();

    // Call the superclass's dispose method.
    super.dispose();
  }

  /// Function that handles the login process and navigation.
  ///
  /// This function retrieves the authentication bloc from the service locator,
  /// creates a login DTO (Data Transfer Object) with the provided username and password,
  /// adds a login event to the authentication bloc, and listens to the bloc's state stream.
  ///
  /// If the state is of type [AuthStateDone], it navigates to the admin dashboard screen.
  /// If the state is of type [AuthStateError], it shows an alert dialog with an error message.
  Future<void> _loginAndNavigate() async {
    // Retrieve the authentication bloc from the service locator
    final authBloc = service<AuthBloc>();

    // Create a login DTO with the provided username and password
    final loginDTO = LoginDTO(
      username: usernameController.text,
      passwordHash: passController.text,
    );

    // Add a login event to the authentication bloc
    authBloc.add(Login(loginDTO: loginDTO));

    // Listen to the bloc's state stream
    authBloc.stream.listen((state) {
      // If the state is of type [AuthStateDone], navigate to the admin dashboard screen
      if (state is AuthStateDone) {
        router.push(Pages.adminDashboard.screenPath);
      }
      // If the state is of type [AuthStateError], show an alert dialog with an error message
      else if (state is AuthStateError) {
        showDialog(
          context: context,
          builder: (context) {
            //TODO: implement correct error handling
            return const AlertDialog(
              content: Text("Invalid username or password"),
            );
          },
        );
      }
    });
  }
}
