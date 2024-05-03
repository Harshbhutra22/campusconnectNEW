import 'package:newcampusconnect/admin/addeventpage.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:newcampusconnect/user/eventTypePage.dart';
import 'package:flutter/material.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: MyText(
          'CampusConnect',
          color: Colors.white,
          size: 25,
          spacing: 2.5,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            userHomepageTileBuilder('Club', context, 'assets/images/club.jpg'),
            const SizedBox(height: 10),
            userHomepageTileBuilder('Extra-Curriculars', context,
                'assets/images/extracurricular.jpg'),
            const SizedBox(height: 10),
            userHomepageTileBuilder(
                'Technical', context, 'assets/images/tech.jpg'),
          ],
        ),
      ),
    );
  }

  userHomepageTileBuilder(String name, BuildContext context, String imgName) {
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EventTypePage(eventType: name);
            },
          ),
        );
      },
      child: Stack(
        children: [
          // ImageBox
          Container(
            height: h * 0.25,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imgName),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text
          Container(
            height: h * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(86, 2, 2, 2),
            ),
            child: Center(
              child: MyText(
                name,
                color: Colors.white,
                size: 30,
                spacing: 3,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
