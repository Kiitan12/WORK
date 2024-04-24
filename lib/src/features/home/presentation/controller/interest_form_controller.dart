import 'package:flutter/material.dart';

// Controller class for managing an interest form
class InterestFormController {
  // GlobalKey to uniquely identify the form widget
  final formKey = GlobalKey<FormState>();

  // TextEditingController for managing the input field for the first field
  final field1 = TextEditingController();

  // TextEditingController for managing the input field for the second field
  final field2 = TextEditingController();
}
