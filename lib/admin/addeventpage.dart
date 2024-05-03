import 'package:newcampusconnect/commons.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatelessWidget {
  AddEventPage({super.key});

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

  @override
  Widget build(BuildContext context) {
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

              MyTextField(
                controller: _feedbackController,
                label: 'Feedback ',
                hint: 'Feedback  for the event',
              ),

              MyTextField(
                controller: _drivelinkController,
                label: 'GoogleDrivelink ',
                hint: 'Google drive link for videos',
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
