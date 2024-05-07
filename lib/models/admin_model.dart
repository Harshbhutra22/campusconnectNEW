import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEventController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void saveEventData(Map<String, dynamic> eventData) {
    try {
      _firestore.collection('events').add(eventData);
      print('Event data successfully saved to Firestore: $eventData');
      print(uid);
    } catch (e) {
      print('Error saving event data to Firestore: $e');
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
      print('Event with ID $eventId successfully deleted');
    } catch (e) {
      print('Error deleting event: $e');
    }
  }
}

//how to use deleteEvent func
/*
AddEventController addEventController = Get.find();
String eventIdToDelete = 'your_event_id_here';
addEventController.deleteEvent(eventIdToDelete);
*/
