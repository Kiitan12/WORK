// importing required packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import necessary files
import 'src/features/authentication/presentation/controller/sign_in_controller.dart';
import 'src/features/authentication/presentation/widget/login.dart';
import 'src/features/home/presentation/widget/bottom_navigation.dart';
import 'src/utils/validation_helper.dart';

// Define a StatefulWidget for handling logging state
class LoggingState extends StatefulWidget {
  const LoggingState({super.key});

  @override
  State<LoggingState> createState() =>
      _LoggingStateState(); // Creating state for LoggingState widget
}

// Define the state class for LoggingState widget
class _LoggingStateState extends State<LoggingState> {
  var user = FirebaseAuth
      .instance.currentUser; // Getting the current user from FirebaseAuth

  @override
  Widget build(BuildContext context) {
    return user != null // Checking if the user is logged in
        ? const BottomNavigation() // If user is logged in, display BottomNavigation widget
        : Login(
            // If user is not logged in, display Login widget
            controller:
                SignInController(), // Providing SignInController to Login widget
            validationHelper:
                ValidationHelper(), // Providing ValidationHelper to Login widget
          );
  }
}
