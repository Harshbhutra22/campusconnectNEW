import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List to store the events
  RxList eventsList = [].obs;

  @override
  void onInit() {
    super.onInit();
    // Call method to fetch events when the controller is initialized
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      // Fetch events from Firestore
      QuerySnapshot querySnapshot = await _firestore.collection('events').get();

      // Clear the existing list
      eventsList.clear();

      // Add fetched events to the list
      querySnapshot.docs.forEach((document) {
        eventsList.add(document.data());
      });

      // Print the fetched events (for debugging)
      eventsList.forEach((event) {
        print(event);
      });
    } catch (e) {
      print('Error fetching events: $e');
    }
  }
}
