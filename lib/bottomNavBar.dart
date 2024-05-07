import 'package:flutter/material.dart';
import 'package:newcampusconnect/admin/adminProfilePage.dart';
import 'package:newcampusconnect/admin/adminscreen.dart';
import 'package:newcampusconnect/models.dart';
import 'package:newcampusconnect/user/userhomepage.dart';

class AdminBottomNavigationBar extends StatefulWidget {
  AdminBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.user});
  int selectedIndex;
  final CCUser user;

  @override
  State<AdminBottomNavigationBar> createState() =>
      _AdminBottomNavigationBarState();
}

class _AdminBottomNavigationBarState extends State<AdminBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    // print('ACC TYPE: ${widget.accountType}');

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: const [
          BoxShadow(color: Color(0xFFB1B1B1), spreadRadius: 0.5, blurRadius: 4),
          BoxShadow(color: Color(0xFFDBDADA), spreadRadius: 0.5, blurRadius: 4)
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 44, 43, 43),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 32.5,
          ),
          elevation: 50,
          unselectedItemColor: const Color(0xFFD2D2D2),
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Account',
            ),
          ],
          currentIndex: widget.selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: (index) {
            print("Button tapped -- $index");
            widget.selectedIndex = index;
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return (widget.user.role == 'user')
                        ? UserHomepage(user: widget.user)
                        : AdmminScreen(user: widget.user);
                  },
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return (widget.user.role == 'user')
                        ? UserHomepage(user: widget.user)
                        : ProfilePage(user: widget.user);
                  },
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfilePage(user: widget.user);
                  },
                ),
              );
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}

class UserBottomNavigationBar extends StatefulWidget {
  UserBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.user});
  int selectedIndex;
  final CCUser user;

  @override
  State<UserBottomNavigationBar> createState() =>
      _UserBottomNavigationBarState();
}

class _UserBottomNavigationBarState extends State<UserBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    // print('ACC TYPE: ${widget.accountType}');

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: const [
          BoxShadow(color: Color(0xFFB1B1B1), spreadRadius: 0.5, blurRadius: 4),
          BoxShadow(color: Color(0xFFDBDADA), spreadRadius: 0.5, blurRadius: 4)
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 44, 43, 43),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 32.5,
          ),
          elevation: 50,
          unselectedItemColor: const Color(0xFFD2D2D2),
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 0,
          selectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Account',
            ),
          ],
          currentIndex: widget.selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: (index) {
            print("Button tapped -- $index");
            widget.selectedIndex = index;
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(user: widget.user),
                ),
              );
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
