import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newcampusconnect/login/loginpage.dart';

class LogoutController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logoutAndNavigateToLogin() async {
    try {
      await _auth.signOut();
      // Reset state if needed
      // Resetting state example:
      // Get.delete<MyStateController>();

      // Navigate to the login page
      Get.offAll(LoginPage(callback: () {}));
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
