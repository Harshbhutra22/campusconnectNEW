import 'package:flutter/material.dart';
import 'package:newcampusconnect/admin/adminscreen.dart';
import 'package:newcampusconnect/backend/authService.dart';
import 'package:newcampusconnect/login/loginpage.dart';
import 'package:newcampusconnect/loginRegisterPageHandler.dart';
import 'package:newcampusconnect/models.dart';
import 'package:newcampusconnect/user/userhomepage.dart';

class Root extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CCUser?>(
      stream: _auth.userStream,
      builder: (context, snapshot) {
        print("Root Widget - Snapshot: $snapshot");

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for authentication state
          return CircularProgressIndicator();
        }

        if (snapshot.data == null) {
          // User is not logged in, show login/register page
          print("User not logged in");
          return LoginRegisterPageHandler();
        } else {
          // User is logged in, determine the user's role and navigate accordingly
          CCUser user = snapshot.data!;
          print("User logged in: $user");

          if (user.role == 'user') {
            return UserHomepage(user: user);
          } else {
            return AdmminScreen(user: user);
          }
        }
      },
    );
  }
}
