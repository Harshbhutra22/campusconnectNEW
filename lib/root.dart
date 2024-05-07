import 'package:flutter/material.dart';
import 'package:newcampusconnect/admin/adminscreen.dart';
import 'package:newcampusconnect/backend/authService.dart';
import 'package:newcampusconnect/login/loginpage.dart';
import 'package:newcampusconnect/loginRegisterPageHandler.dart';
import 'package:newcampusconnect/models.dart';
import 'package:newcampusconnect/user/userhomepage.dart';

class Root extends StatelessWidget {
  Root({super.key});
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth.userStream,
      builder: (context, snapshot) {
        print("--->>> ${snapshot.data}");
        if (snapshot.data != null) {
          CCUser user = snapshot.data!;

          if (user.role == 'user') {
            return UserHomepage(user: user);
          } else {
            return AdmminScreen(user: user);
          }
        } else {
          return const LoginRegisterPageHandler();
        }
      },
    );
  }
}
