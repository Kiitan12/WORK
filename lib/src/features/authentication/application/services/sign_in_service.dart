import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/globals.dart';
import 'package:volun_tek/src/routing/routes.dart';

class SignInService extends StateNotifier<bool> {
  final FirebaseAuth auth;

  SignInService(this.auth) : super(false);

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      state = true;
      await auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => navigatorKey.currentState!
              .pushNamedAndRemoveUntil(bottomNavigation, (route) => false));
      state = false;
    } on FirebaseAuthException catch (e) {
      state = false;
      snackBarKey.currentState!.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.message ?? 'An error occurred'),
        ),
      );
      throw e.message ?? 'An error occurred';
    }
  }
}
