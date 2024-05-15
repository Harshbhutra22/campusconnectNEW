import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newcampusconnect/commons.dart';
import 'package:get/get.dart';
import 'package:newcampusconnect/models/admin_model.dart';

class AddEventPage extends StatefulWidget {
  final String typeOfEvent;

  const AddEventPage({super.key, required this.typeOfEvent});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final AddEventController addEventController = Get.put(AddEventController());

  // Controllers
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final TextEditingController _venueController = TextEditingController();

  final TextEditingController _organiserNameController =
      TextEditingController();

  final TextEditingController _formLinkController = TextEditingController();

  final TextEditingController _feedbackController = TextEditingController();

  final TextEditingController _drivelinkController = TextEditingController();

  File? _poster;

  int generateRandomNumber() {
    Random random = Random();
    return 10000000 + random.nextInt(99999999 - 10000000);
  }

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
                            key: UniqueKey(),
                            onTap: () async {
                              XFile? x = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                  requestFullMetadata: false);
                              if (x != null) {
                                _poster = File(x.path);
                              }
                              setState(() {});
                            },
                            child: Container(
                              color: const Color.fromARGB(53, 158, 158, 158),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: (_poster != null)
                                    ? Image.file(
                                        _poster!.absolute,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.add_rounded,
                                        size: 35,
                                        color: Color(0xFF7C7C7C),
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
                  onTap: () async {
                    // upload file to firebase storage and get its download url
                    int randomlyGenerated_pID = generateRandomNumber();
                    Reference posterRef = FirebaseStorage.instance.ref().child(
                        '$randomlyGenerated_pID/poster/${_poster!.path.split('/').last}');
                    UploadTask receiptUploadTask = posterRef.putFile(_poster!);
                    TaskSnapshot thumbnailSnapshot =
                        await receiptUploadTask.whenComplete(() {});
                    String posterDownloadUrl =
                        await thumbnailSnapshot.ref.getDownloadURL();

                    // Prepare event data
                    Map<String, dynamic> eventData = {
                      'name': _nameController.text,
                      'description': _descController.text,
                      'date': _dateController.text,
                      'time': _timeController.text,
                      'venue': _venueController.text,
                      'organiserName': _organiserNameController.text,
                      'registrationLink': _formLinkController.text,
                      'driveLink': _drivelinkController.text,
                      'posterURL': posterDownloadUrl
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
