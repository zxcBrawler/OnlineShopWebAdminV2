import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/button/auth_button.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/auth/desktop_auth_page.dart';
import 'package:xc_web_admin/config/responsive.dart';

class MobileAuthPage extends StatefulWidget {
  const MobileAuthPage({super.key});

  @override
  State<MobileAuthPage> createState() => _MobileAuthPageState();
}

class _MobileAuthPageState extends State<MobileAuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context) && !Responsive.isDesktop(context)) {
      return Row(
        children: [
          Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
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
                    const AuthButton(),
                  ],
                ),
              )),
        ],
      );
    } else if (Responsive.isTablet(context) && !Responsive.isDesktop(context)) {
      return Row(
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
                    const AuthButton(),
                  ],
                ),
              )),
          Expanded(flex: 1, child: Container()),
        ],
      );
    } else {
      return const DesktopAuthPage();
    }
  }
}
