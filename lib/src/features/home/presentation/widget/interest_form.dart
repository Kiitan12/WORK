import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/common_widgets/tek_elevated_button.dart';
import 'package:volun_tek/src/common_widgets/tek_text_field.dart';
import 'package:volun_tek/src/constants/app_style.dart';
import 'package:volun_tek/src/constants/colors.dart';
import 'package:volun_tek/src/features/home/presentation/controller/interest_form_controller.dart';

import '../../../../utils/validation_helper.dart';
import '../provider/task_provider.dart';

// Widget for the interest form
class InterestForm extends ConsumerStatefulWidget {
  const InterestForm({
    super.key,
    required this.validation,
    required this.controller,
  });

  // Required validation helper for form fields
  final ValidationHelper validation;
  // Controller for managing form state and field values
  final InterestFormController controller;

  @override
  ConsumerState<InterestForm> createState() => _InterestFormState();
}

class _InterestFormState extends ConsumerState<InterestForm> {
  @override
  Widget build(BuildContext context) {
    final task = ref.watch(taskProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        // Title of the interest form page
        title: Text(
          'Interest Form',
          style: AppStyle.kHeading1.copyWith(
            color: kGray16,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SingleChildScrollView(
          child: Form(
            // Setting the form key for validation and submission
            key: widget.controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Displaying the title of the task
                Text(
                  task.title,
                  style: AppStyle.kRegular20
                      .copyWith(color: kGray16, fontSize: 25),
                ),
                const SizedBox(height: 44),
                Text('Describe yourself?', style: AppStyle.kRegular16Inter),
                const SizedBox(height: 16),
                TekTextField(
                  hint: 'Type here...',
                  inputController: widget.controller.field1,
                  validator: (value) {
                    return widget.validation.validateField(value!);
                  },
                  maxLines: 6,
                ),
                const SizedBox(height: 48),
                Text(
                  'Do you have any prior experience volunteering'
                  ' or working in a similar field?',
                  style: AppStyle.kRegular16Inter,
                ),
                const SizedBox(height: 20),
                // Text field widget with validation
                TekTextField(
                  hint: 'Type here...',
                  inputController: widget.controller.field2,
                  validator: (value) {
                    return widget.validation.validateField(value!);
                  },
                  maxLines: 6,
                ),
                const SizedBox(height: 48),
                // Elevated button for form submission
                TekElevatedButton(
                  child: ref.watch(loadingTaskProvider)
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Submit'),
                  onPressed: () async {
                    // Validating form fields before submission
                    if (widget.controller.formKey.currentState!.validate()) {
                      // Submitting interest form data
                      ref.read(loadingTaskProvider.notifier).submitInterest(
                            task.id,
                            widget.controller.field1.text,
                            widget.controller.field2.text,

                            // Retrieving user's name for submission
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get()
                                .then((value) => value.data()!['name']),
                          );
                    }
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
