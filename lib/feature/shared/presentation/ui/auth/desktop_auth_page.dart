import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/button/auth_button.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';

class DesktopAuthPage extends StatefulWidget {
  const DesktopAuthPage({super.key});

  @override
  State<DesktopAuthPage> createState() => _DesktopAuthPageState();
}

class _DesktopAuthPageState extends State<DesktopAuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: SizedBox(
                          width: 200,
                          height: 200,
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
        Expanded(flex: 1, child: Container())
      ],
    );
  }
}
