import 'package:flutter/material.dart';

import '../commons.dart';
import '../models.dart';

class EventInfoPage extends StatelessWidget {
  EventInfoPage({super.key, required this.event});
  Event event;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: h * 0.35,
                    width: (h * 0.35) * 0.725,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(event.imgName), fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),

              // Name
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(event.name,
                      size: 26, weight: FontWeight.bold, spacing: 1.25),
                ],
              ),

              const SizedBox(height: 20),

              // Organiser name
              Row(
                children: [
                  MyText('Organised by: ', size: 16, weight: FontWeight.bold),
                  MyText(event.organisation, size: 16, spacing: 1.5),
                ],
              ),

              // Desc
              const SizedBox(height: 20),
              MyText('About', size: 18, weight: FontWeight.w600),
              MyText(event.desc),

              // Date
              const SizedBox(height: 20),
              Row(
                children: [
                  MyText('Date: ', weight: FontWeight.bold),
                  MyText(event.date),
                ],
              ),

              // Time
              const SizedBox(height: 20),
              Row(
                children: [
                  MyText('Time: ', weight: FontWeight.bold),
                  MyText(event.time),
                ],
              ),

              // Venue
              const SizedBox(height: 20),
              Row(
                children: [
                  MyText('Venue: ', weight: FontWeight.bold),
                  MyText(event.venue),
                ],
              ),

              // Drive link - if applicable
              const SizedBox(height: 20),
              if (event.driveLink != null)
                Row(
                  children: [
                    MyText('Drive Link: ', weight: FontWeight.bold),
                    MyText(event.driveLink!),
                  ],
                ),

              // Register Button
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Register button pressed');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: MyText(
                          'Register Now',
                          color: Colors.white,
                          weight: FontWeight.bold,
                          spacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
