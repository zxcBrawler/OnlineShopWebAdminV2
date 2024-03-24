import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
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
    usernameController.text = "admin";
    passController.text = "admin";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => service<AuthBloc>(),
      child: Responsive.isMobile(context)
          ? _buildMobileAuthPage(context)
          : _buildDesktopAuthPage(context),
    );
  }

  /// Builds the mobile authentication page.
  ///
  /// This widget is responsible for building the mobile authentication page.
  /// It returns a [Scaffold] widget with a [Column] as its child.
  /// The [Column] contains an [Expanded] widget which contains a [Column].
  /// The inner [Column] is responsible for displaying the logo, username field,
  /// password field, and authentication button.
  ///
  /// Parameters:
  ///   - context: The [BuildContext] of the widget.
  ///
  /// Returns:
  ///   A [Scaffold] widget.
  Widget _buildMobileAuthPage(BuildContext context) {
    return Scaffold(
      // The scaffold's body is a column.
      body: Column(
        // The column expands to fill the available space.
        children: [
          Expanded(
            // The expanded widget expands to fill the available space.
            child: Column(
              // The column is centered vertically.
              mainAxisAlignment: MainAxisAlignment.center,
              // The children of the column are the logo, username field,
              // password field, and authentication button.
              children: [
                // The logo of the application.
                _buildLogo(),
                // The text field for entering the username.
                _buildUsernameField(),
                // The text field for entering the password.
                _buildPasswordField(),
                // The button for authenticating the user.
                _buildAuthButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the desktop authentication page.
  ///
  /// This function returns a [Scaffold] widget with a [Row] as its child.
  /// The [Row] contains two [Spacer] widgets and an [Expanded] widget.
  /// The [Expanded] widget expands to fill the available space and has a flex of 4.
  /// Inside the [Expanded] widget, there is a [Padding] widget with horizontal padding of 50.
  /// Inside the [Padding] widget, there is a [Column] widget. The [Column] contains the logo,
  /// username field, password field, and authentication button.
  ///
  /// Parameters:
  ///   - context: The [BuildContext] of the widget.
  ///
  /// Returns:
  ///   A [Scaffold] widget.
  Widget _buildDesktopAuthPage(BuildContext context) {
    return Scaffold(
      // The scaffold's body is a row.
      body: Row(
        // The row contains two spacers and an expanded widget.
        children: [
          // The spacer widget expands to fill the available space.
          const Spacer(),
          Expanded(
            // The expanded widget expands to fill the available space,
            // and has a flex of 4.
            flex: 4,
            child: Padding(
              // The padding widget has horizontal padding of 50.
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                // The column contains the logo, username field,
                // password field, and authentication button.
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // The logo of the application.
                  _buildLogo(),
                  // The text field for entering the username.
                  _buildUsernameField(),
                  // The text field for entering the password.
                  _buildPasswordField(),
                  // The button for authenticating the user.
                  _buildAuthButton(context),
                ],
              ),
            ),
          ),
          // The spacer widget expands to fill the available space.
          const Spacer(),
        ],
      ),
    );
  }

  /// Builds the logo widget for the authentication page.
  ///
  /// This widget centers an image of the XC logo with dimensions 150x150
  /// and returns it as a [Center] widget.
  ///
  /// Returns:
  ///   A [Center] widget containing a [SizedBox] with the XC logo image.
  Widget _buildLogo() {
    // The logo is centered in the screen.
    return Center(
      child: SizedBox(
        // The logo image has a width and height of 150 pixels.
        width: 150,
        height: 150,
        // The image is an asset with the path "assets/xc-logo-transparent.png".
        child: Image.asset("assets/xc-logo-transparent.png"),
      ),
    );
  }

  /// Builds the username field widget for the  authentication page.
  ///
  /// This widget creates a [BasicTextField] with the key "authUsernameInput",
  /// a title of "username", the provided [usernameController], and enabled state of true.
  ///
  /// Returns:
  ///   A [BasicTextField] widget for the username field.
  Widget _buildUsernameField() {
    // The username field is a BasicTextField with the provided key,
    // title, controller, and enabled state.
    return BasicTextField(
      key: const Key("authUsernameInput"), // Key for the field.
      title: "username", // Title of the field.
      controller: usernameController, // Controller for the field's text.
      isEnabled: true, // The field is enabled.
    );
  }

  /// Builds the password field widget for the authentication page.
  ///
  /// This widget creates a [BasicTextField] with the key "authPasswordInput",
  /// a title of "password", the provided [passController], and enabled state of true.
  ///
  /// Returns:
  ///   A [BasicTextField] widget for the password field.
  Widget _buildPasswordField() {
    // The password field is a BasicTextField with the provided key,
    // title, controller, and enabled state.
    return BasicTextField(
      key: const Key("authPasswordInput"), // Key for the field.
      title: "password", // Title of the field.
      controller: passController, // Controller for the field's text.
      isEnabled: true, // The field is enabled.
    );
  }

  /// Builds the authentication button widget.
  ///
  /// This function returns a [Padding] widget containing a [Row] widget
  /// with a single [Expanded] widget. The [Expanded] widget contains an
  /// [ElevatedButton] widget with the provided [BuildContext] and an
  /// [onPressed] function that calls [_loginAndNavigate]. The style of the
  /// button includes a background color of [AppColors.darkBrown] and a
  /// rounded border with a circular radius of 30. The child of the button is
  /// an [AuthButtonText] widget with the title "auth".
  ///
  /// Parameters:
  ///   - context: The [BuildContext] of the widget.
  ///
  /// Returns:
  ///   A [Padding] widget containing a [Row] widget with a single
  ///   [Expanded] widget.
  Widget _buildAuthButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              key: const Key("authButton"),
              onPressed: () async {
                // Call the loginAndNavigate function when the button is pressed.
                await _loginAndNavigate();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const AuthButtonText(title: "auth"),
            ),
          ),
        ],
      ),
    );
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

  /// Handles the login process and navigation.
  ///
  /// This function retrieves the authentication bloc from the service locator,
  /// creates a login DTO (Data Transfer Object) with the provided username and password,
  /// adds a login event to the authentication bloc, and listens to the bloc's state stream.
  ///
  /// If the state is of type [AuthStateDone], it navigates to the appropriate dashboard screen based on the user's role.
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
      if (state is AuthStateLoading) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: CircularProgressIndicator(),
            );
          },
        );
      }
      // Check the type of the state and perform the appropriate action
      if (state is AuthStateDone) {
        // Navigate to the appropriate dashboard screen based on the user's role
        _navigateToDashboard(
          state.loginResponse!.userEntity!.role!.roleName!,
          state.loginResponse!.userEntity!.id!,
        );
      } else if (state is AuthStateError) {
        // Show an alert dialog with an error message
        _showErrorDialog();
      }
    });
  }

  /// Navigates to the appropriate dashboard screen based on the user's role.
  ///
  /// Takes the user's role as a parameter and navigates to the corresponding dashboard screen.
  /// If the user's role is not recognized, it shows an alert dialog with an error message.
  ///
  /// Parameters:
  ///   - role: The role of the user.
  void _navigateToDashboard(String role, int id) {
    // Switch statement based on the user's role
    switch (role) {
      // If the user is an admin, navigate to the admin dashboard
      case "admin":
        router.go(Pages.adminDashboard.screenPath);
        break;
      // If the user is a director, navigate to the director dashboard and save the director id
      case "director":
        SessionStorage.saveLocalData("role", role);
        SessionStorage.saveLocalData("employeeId", id);
        router.go(Pages.directorDashboard.screenPath);

        break;
      // If the user is an employee, navigate to the employee dashboard and save the employee id
      case "employee":
        SessionStorage.saveLocalData("role", role);
        SessionStorage.saveLocalData("employeeId", id);
        router.go(Pages.employeeDashboard.screenPath);

        break;
      // If the user's role is 'user', show an alert dialog with an error message
      case "user":
        showDialog(
          context: context,
          builder: (context) {
            // Return an alert dialog with an error message
            return const AlertDialog(
              content: Text("you don't have permission to access this app"),
            );
          },
        );
        break;
      // If the user's role is not recognized, show an error dialog
      default:
        _showErrorDialog();
        break;
    }
  }

  /// Shows an alert dialog with an error message.
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text("invalid username or password"),
        );
      },
    );
  }
}
