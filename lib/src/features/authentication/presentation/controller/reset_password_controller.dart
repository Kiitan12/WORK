import 'package:flutter/material.dart';

// A controller class for managing the state and behavior of the reset password form
class ResetPasswordController {
  // GlobalKey for the reset password form
  final formKey = GlobalKey<FormState>();
  // TextEditingController for the email field in the reset password form
  final email = TextEditingController();
}
