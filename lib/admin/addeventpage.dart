import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:get/get.dart';
import 'package:newcampusconnect/models/admin_model.dart';

class AddEventPage extends StatefulWidget {
  final String typeOfEvent;

  const AddEventPage({Key? key, required this.typeOfEvent}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final AddEventController addEventController = Get.put(AddEventController());
  final TextEditingController _id=TextEditingController();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _organiserNameController = TextEditingController();
  final TextEditingController _formLinkController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _drivelinkController = TextEditingController();
  File? _receipt;

  @override
  Widget build(BuildContext context) {
    print(widget.typeOfEvent);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText('Provide event details', size: 18, weight: FontWeight.bold, spacing: 1),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _nameController,
                  label: 'Event Name',
                  hint: 'What is the name of your event',
                ),
                MyTextField(
                  controller: _descController,
                  label: 'Event Description',
                  hint: 'Tell us about your event',
                ),
                MyTextField(
                  controller: _dateController,
                  label: 'Event Date',
                  hint: 'When is the event',
                ),
                MyTextField(
                  controller: _timeController,
                  label: 'Event Time',
                  hint: 'Timing of your event',
                ),
                MyTextField(
                  controller: _venueController,
                  label: 'Event Venue',
                  hint: 'Where is your event hosted at',
                ),
                MyTextField(
                  controller: _organiserNameController,
                  label: 'Organiser Name',
                  hint: 'Who is organising the event',
                ),
                MyTextField(
                  controller: _formLinkController,
                  label: 'Registration Link',
                  hint: 'Registration link for the event',
                ),
                MyTextField(
                  controller: _drivelinkController,
                  label: 'Google Drive Link',
                  hint: 'Google drive link for videos',
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 17.5),
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
                              final imagePicker = ImagePicker();
                              final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  _receipt = File(image.path);
                                });
                              }
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              color: const Color.fromARGB(87, 158, 158, 158),
                              child: Center(
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
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // Prepare event data
                    Map<String, dynamic> eventData = {
                      'id':_id,
                      'name': _nameController.text,
                      'description': _descController.text,
                      'date': _dateController.text,
                      'time': _timeController.text,
                      'venue': _venueController.text,
                      'organiserName': _organiserNameController.text,
                      'registrationLink': _formLinkController.text,
                      'driveLink': _drivelinkController.text,
                      // Add other fields as needed
                    };

                    // Call controller method to save event data
                    addEventController.saveEventData(eventData);
                    print("Event data: $eventData"); // Debug statement
                    print("Complete"); // Debug statement
                    Get.back();
                  },
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
      ),
    );
  }
}
