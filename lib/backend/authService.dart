import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newcampusconnect/models.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference<Map<String, dynamic>> _store = FirebaseFirestore.instance.collection('users');

  Stream<CCUser?> get userStream async* {
    var result = _auth.authStateChanges();

    await for (var user in result) {
      if (user != null) {
        try {
          Map userDetails = await getOtherUserDetails(user.email!);
          yield CCUser(
            email: user.email!,
            role: userDetails['role'],
            name: userDetails['name'],
            uID: userDetails['uID'],
          );
        } catch (e) {
          print("Error fetching user details: $e");
          yield null;
        }
      } else {
        yield null;
      }
    }
  }

  Future<Map<String, dynamic>> getOtherUserDetails(String email) async {
    var x = await _store.doc(email).get();

    return {
      'role': x.data()!['role'],
      'email': x.data()!['email'],
      'name': x.data()!['name'],
      'uID': x.data()!['uID'],
    };
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  int generateUID() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 10; i++) {
      number += random.nextInt(10).toString();
    }
    return int.parse(number);
  }

  Future<String> signInWithEmailAndPassword(
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

  Future<String> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return '';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser!.delete();
    _auth.signOut();
    print('Account Deleted!');
  }
}