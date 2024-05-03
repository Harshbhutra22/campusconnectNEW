import 'package:newcampusconnect/admin/adminscreen.dart';
import 'package:newcampusconnect/login/loginpage.dart';
import 'package:newcampusconnect/login/registerpage.dart';
import 'package:newcampusconnect/user/userhomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     // options: DefaultFirebsaseOptions.currentPlatform,
  //     );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: SignupPage(),
    );
  }
}
