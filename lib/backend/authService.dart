import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newcampusconnect/models.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance.collection('users');

  // function to generate UID - used while signing up a user
  int generateUID() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 10; i++) {
      number += random.nextInt(10).toString();
    }
    return int.parse(number);
  }

  Stream<CCUser?> get userStream async* {
    var result = _auth.authStateChanges();

    await for (var user in result) {
      if (user != null) {
        // Wait for getOtherUserDetails() to complete before continuing
        Map deets = await getOtherUserDetails(user.email!);
        // print(deets);
        yield CCUser(
          email: user.email!,
          role: deets['role'],
          name: deets['name'],
          uID: deets['uID'],
        );
      } else {
        yield null;
      }
    }
  }

  // Auxiliary function to fetch all of a user's details from firestore
  getOtherUserDetails(String email) async {
    var x = await _store.doc(email).get();

    return {
      'role': x.data()!['role'],
      'email': x.data()!['email'],
      'name': x.data()!['name'],
      'uID': x.data()!['uID'],
    };
  }

  Future logout() async {
    await _auth.signOut();
  }

  signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signUpWithUserCredentials({
    required String name,
    required String role,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _store.doc(email).set({
        'name': name,
        'pwd': password,
        'email': email,
        'role': role,
        'uID': generateUID(),
      });
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  deleteAccount() async {
    await _auth.currentUser!.delete();
    _auth.signOut();
    print('Account Deleted!');
  }
}
