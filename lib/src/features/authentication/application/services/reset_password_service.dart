import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/globals.dart';

import '../../../../constants/colors.dart';

/// A class to handle resetting password via email.
class ResetPasswordService extends StateNotifier<bool> {
  final FirebaseAuth auth;

  /// Constructor for the [ResetPasswordService].
  ResetPasswordService(this.auth) : super(false);

  /// Sends a password reset email to the specified email address.
  Future<void> resetPasswordWithEmail({
    required String email,
  }) async {
    try {
      state = true;
      // Send password reset email
      await auth.sendPasswordResetEmail(email: email).then((value) {
        // Show snack bar indicating success
        snackBarKey.currentState!.showSnackBar(const SnackBar(
          content: Text('Password reset link sent to your email'),
          backgroundColor: kBlue,
        ));
        // Pop the current screen from the navigation stack
        navigatorKey.currentState!.pop();
      });
      state = false;
    } on FirebaseAuthException catch (e) {
      // In case of Firebase Auth exception, set state to false and throw error message
      state = false;
      throw e.message ?? 'An error occurred';
    }
  }
}
