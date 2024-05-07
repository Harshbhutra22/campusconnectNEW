import 'package:flutter/material.dart';
import 'package:newcampusconnect/login/loginpage.dart';
import 'package:newcampusconnect/login/registerpage.dart';

class LoginRegisterPageHandler extends StatefulWidget {
  const LoginRegisterPageHandler({super.key});

  @override
  State<LoginRegisterPageHandler> createState() =>
      _LoginRegisterPageHandlerState();
}

class _LoginRegisterPageHandlerState extends State<LoginRegisterPageHandler> {
  bool showLoginPage = true;

  @override
  Widget build(BuildContext context) {
    switchPage() {
      showLoginPage = !showLoginPage;
      setState(() {});
    }

    return (showLoginPage)
        ? LoginPage(
            callback: switchPage,
          )
        : SignupPage(
            callback: switchPage,
          );
  }
}
