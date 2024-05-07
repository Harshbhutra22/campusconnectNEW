import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatelessWidget {
  AddEventPage({super.key, required this.typeOfEvent});

  // Controllers
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _venueController = TextEditingController();
  final _organiserNameController = TextEditingController();
  final _formLinkController = TextEditingController();
  final _feedbackController = TextEditingController();
  final _drivelinkController = TextEditingController();
  File? _receipt;
  final String typeOfEvent;

  @override
  Widget build(BuildContext context) {
    print(typeOfEvent);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText('Provide event details',
                  size: 18, weight: FontWeight.bold, spacing: 1),
              const SizedBox(height: 10),

              // Name
              MyTextField(
                controller: _nameController,
                label: 'Event Name',
                hint: 'What is the name of your event',
              ),

              // Desc
              MyTextField(
                controller: _descController,
                label: 'Event Description',
                hint: 'Tell us about your event',
              ),

              // Date
              MyTextField(
                controller: _dateController,
                label: 'Event Date',
                hint: 'When is the event',
              ),

              // Time
              MyTextField(
                controller: _timeController,
                label: 'Event Time',
                hint: 'Timing of your event',
              ),

              // Venue
              MyTextField(
                controller: _venueController,
                label: 'Event Venue',
                hint: 'Where is your event hosted at',
              ),

              // Organiser
              MyTextField(
                controller: _organiserNameController,
                label: 'Organiser Name',
                hint: 'Who is organising the event',
              ),

              // Registration link
              MyTextField(
                controller: _formLinkController,
                label: 'Registration Link',
                hint: 'Registration link for the event',
              ),

              // Google Drive Link
              MyTextField(
                controller: _drivelinkController,
                label: 'GoogleDrivelink ',
                hint: 'Google drive link for videos',
              ),

              // Poster Uploader
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.5, vertical: 17.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'Upload a poster',
                      size: 14,
                      weight: FontWeight.w400,
                      spacing: 1,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var x = ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            print('Image Picker');
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            color: const Color.fromARGB(87, 158, 158, 158),
                            child: const Center(
                              child: Icon(
                                Icons.add_rounded,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Submit button
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: MyText(
                      'Submit',
                      color: Colors.white,
                      spacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
