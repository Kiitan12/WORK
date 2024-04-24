import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/globals.dart';
import 'package:volun_tek/src/constants/colors.dart';

class SignUpService extends StateNotifier<bool> {
  final FirebaseAuth auth;

  SignUpService(this.auth) : super(false);

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      state = true;
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(
        {
          'email': email,
          'name': name,
          'uid': auth.currentUser!.uid,
        },
      ).then((value) {
        snackBarKey.currentState!.showSnackBar(const SnackBar(
          content: Text('Account created successfully'),
          backgroundColor: kBlue,
        ));
        navigatorKey.currentState!.pop();
      });
      state = false;
    } on FirebaseAuthException catch (e) {
      state = false;
      snackBarKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
      throw e.message ?? 'An error occurred';
    }
  }
}
