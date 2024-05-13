import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:newcampusconnect/backend/authService.dart';
import 'package:newcampusconnect/bottomNavBar.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:newcampusconnect/login/loginpage.dart';
import 'package:newcampusconnect/login/registerpage.dart';
import 'package:newcampusconnect/models.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.user});
  final CCUser user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: MyText(
          'CampusConnect',
          color: Colors.white,
          size: 20,
          spacing: 1.25,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account information
          Container(
            height: 200,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    (widget.user.role == 'user')
                        ? const Icon(Icons.person_rounded,
                            color: Colors.white, size: 85)
                        : const Icon(Icons.settings_suggest_rounded,
                            color: Colors.white, size: 85),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        MyText(widget.user.name, color: Colors.white, size: 30),
                        MyText(widget.user.email,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Account Settings
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: MyText(
              'Account Settings',
              spacing: 1,
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(81, 158, 158, 158),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await AuthService().logout();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(
                            callback: () {},
                          ),
                        ));
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.logout),
                      const SizedBox(width: 10),
                      MyText('Logout'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.refresh_rounded),
                      const SizedBox(width: 10),
                      MyText('Reset Password'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.delete_rounded, color: Colors.red),
                      const SizedBox(width: 10),
                      MyText('Delete Account', color: Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          AdminBottomNavigationBar(selectedIndex: 1, user: widget.user),
    );
  }
}
