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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      //TODO: implement auth page for mobile
      return const SizedBox();
    } else {
      return BlocProvider(
        create: (context) => service<AuthBloc>(),
        child: Row(
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: SizedBox(
                            width: 150,
                            height: 150,
                            child:
                                Image.asset("assets/xc-logo-transparent.png"))),
                    BasicTextField(
                      title: "email",
                      controller: emailController,
                      isEnabled: true,
                    ),
                    BasicTextField(
                      title: "password",
                      controller: passController,
                      isEnabled: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
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
            Expanded(flex: 1, child: Container()),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  Future<void> _loginAndNavigate() async {
    final authBloc = service<AuthBloc>();
    final loginDTO = LoginDTO(
      username: emailController.text,
      passwordHash: passController.text,
    );

    authBloc.add(Login(loginDTO: loginDTO));

    authBloc.stream.listen((state) {
      if (state is AuthStateDone) {
        print(state.loginResponse!.accessToken);
        router.push(Pages.adminDashboard.screenPath);
      } else if (state is AuthStateError) {
        showDialog(
            context: context,
            builder: (context) {
              //TODO: implement correct error handling
              return AlertDialog(
                content: Text(state.error.toString()),
              );
            });
      }
    });
  }
}
