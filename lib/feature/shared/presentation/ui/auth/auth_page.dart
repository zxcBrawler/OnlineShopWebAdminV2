import 'package:flutter/material.dart';
import 'package:xc_web_admin/feature/shared/presentation/ui/auth/mobile_auth_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MobileAuthPage(),
    );
  }
}
