import 'package:newcampusconnect/admin/addeventpage.dart';
import 'package:newcampusconnect/bottomNavBar.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:flutter/material.dart';
import 'package:newcampusconnect/models.dart';

class AdmminScreen extends StatelessWidget {
  const AdmminScreen({super.key, required this.user});
  final CCUser user;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText('Add an event',
                size: 18, weight: FontWeight.bold, spacing: 1),
            const SizedBox(height: 10),
            adminPageTileBuilder('Club', context),
            const SizedBox(height: 10),
            adminPageTileBuilder('Extra-Curriculars', context),
            const SizedBox(height: 10),
            adminPageTileBuilder('Technical', context),
          ],
        ),
      ),
      bottomNavigationBar:
          AdminBottomNavigationBar(selectedIndex: 0, user: user),
    );
  }

  adminPageTileBuilder(String name, BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return AddEventPage(typeOfEvent: name.toLowerCase());
            },
          ),
        );
      },
      child: Container(
        height: (h - kBottomNavigationBarHeight - 30) * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(123, 158, 158, 158),
        ),
        child: Center(
          child: MyText(
            name,
            color: Colors.black,
            size: 20,
            spacing: 1.5,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
