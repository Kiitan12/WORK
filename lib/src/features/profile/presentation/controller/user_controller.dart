// Import statement for the Flutter Material package
import 'package:flutter/material.dart';

// Controller class for managing user data in forms
class UserController {
  // GlobalKey for managing the form state
  final formKey = GlobalKey<FormState>();

  // TextEditingController for managing user location input
  final location = TextEditingController();

  // TextEditingController for managing user bio input
  final bio = TextEditingController();
}
