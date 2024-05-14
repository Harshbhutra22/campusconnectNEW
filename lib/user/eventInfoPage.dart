import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for user authentication
import 'package:firebase_database/firebase_database.dart';
import '../commons.dart';
import '../models.dart';

class UserRegistration {
  final String eventId;
  final String userId;

  UserRegistration({required this.eventId, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'userId': userId,
    };
  }
}

class EventInfoPage extends StatelessWidget {
  final Event event;
  final DatabaseReference _userRegistrationsRef =
  FirebaseDatabase.instance.reference().child('user_registrations');

  EventInfoPage({Key? key, required this.event}) : super(key: key);

  Future<String> getUserId() async {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is authenticated
    if (user != null) {
      // Return the user ID
      return user.uid;
    } else {
      // Return an empty string if user is not authenticated
      return '';
    }
  }

  void registerForEvent() async {
    // Retrieve user ID asynchronously
    String userId = await getUserId();

    // Check if user ID is available
    if (userId.isNotEmpty) {
      // Create a UserRegistration object with event ID and user ID
      UserRegistration registration = UserRegistration(eventId: event.id, userId: userId);

      // Push the registration data to Firebase Realtime Database
      _userRegistrationsRef.push().set(registration.toJson());

      print('User registered for event ${event.name}');
    } else {
      print('User ID is empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final String defaultImageUrl = 'assets/images/DYPIU_Logo.jpg';
    final String imageUrl =
    event.imgName?.isNotEmpty == true ? event.imgName! : defaultImageUrl;

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
          child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: h * 0.35,
                    width: (h * 0.35) * 0.725,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(event.name ?? '', size: 26, weight: FontWeight.bold, spacing: 1.25),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  MyText('Organised by: ', size: 16, weight: FontWeight.bold),
                  MyText(event.organisation ?? '', size: 16, spacing: 1.5),
                ],
              ),
              const SizedBox(height: 20),
              MyText('About', size: 18, weight: FontWeight.w600),
              MyText(event.desc ?? ''),
              const SizedBox(height: 20),
              Row(
                children: [
                  MyText('Date: ', weight: FontWeight.bold),
                  MyText(event.date ?? ''),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  MyText('Time: ', weight: FontWeight.bold),
                  MyText(event.time ?? ''),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  MyText('Venue: ', weight: FontWeight.bold),
                  MyText(event.venue ?? ''),
                ],
              ),
              const SizedBox(height: 20),
              if (event.driveLink != null)
                Row(
                  children: [
                    MyText('Drive Link: ', weight: FontWeight.bold),
                    MyText(event.driveLink!),
                  ],
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: registerForEvent, // Call function to register user for the event
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
