import 'package:flutter/material.dart';
import 'package:newcampusconnect/login/loginpage.dart';
import 'package:newcampusconnect/login/registerpage.dart';

class LoginRegisterPageHandler extends StatefulWidget {
  const LoginRegisterPageHandler({Key? key}) : super(key: key);

  @override
  State<LoginRegisterPageHandler> createState() =>
      _LoginRegisterPageHandlerState();
}

class _LoginRegisterPageHandlerState extends State<LoginRegisterPageHandler> {
  bool showLoginPage = true;

  void switchPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (showLoginPage)
        ? LoginPage(
      callback: switchPage,
    )
        : SignupPage(
      callback: switchPage,
    );
  }
}
