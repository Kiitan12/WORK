import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/constants/colors.dart';
import 'package:volun_tek/src/features/authentication/presentation/provider/reset_password_provider.dart';

import '../../../../common_widgets/tek_elevated_button.dart';
import '../../../../common_widgets/tek_text_field.dart';
import '../../../../constants/app_style.dart';
import '../../../../utils/validation_helper.dart';
import '../controller/reset_password_controller.dart';

// ResetPassword widget ddefined
class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
    required this.validationHelper,
    required this.controller,
  });

  final ValidationHelper validationHelper;
  final ResetPasswordController controller;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

// State class for the ResetPassword widget
class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: AppStyle.kHeading1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: widget.controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Semantics(
                  label: 'Email Field',
                  child: Text('Email', style: AppStyle.kRegular20)),
              const SizedBox(height: 4),
              TekTextField(
                hint: 'Enter your email',
                validator: (value) {
                  return widget.validationHelper.validateEmail(value!);
                },
                inputController: widget.controller.email,
              ),
              const SizedBox(height: 85),
              Consumer(builder: (context, ref, child) {
                return TekElevatedButton(
                  title: 'Send',
                  onPressed: () {
                    if (widget.controller.formKey.currentState!.validate()) {
                      ref
                          .read(resetPasswordProvider.notifier)
                          .resetPasswordWithEmail(
                            email: widget.controller.email.text.trim(),
                          );
                    }
                  },
                  child: ref.watch(resetPasswordProvider)
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Send',
                          style: AppStyle.kRegular16,
                        ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
