import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/constants/app_style.dart';
import 'package:volun_tek/src/constants/colors.dart';
import 'package:volun_tek/src/routing/routes.dart';

import '../../../../common_widgets/tek_elevated_button.dart';
import '../../../../common_widgets/tek_text_field.dart';
import '../../../../utils/validation_helper.dart';
import '../controller/sign_in_controller.dart';
import '../provider/sign_in_provider.dart';
import '../provider/sign_up_provider.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
    required this.validationHelper,
    required this.controller,
  });

  final ValidationHelper validationHelper;
  final SignInController controller;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, top: 8),
          child: SingleChildScrollView(
            child: Form(
              key: widget.controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Login', style: AppStyle.kHeading1),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/login.png',
                      height: 295,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Email', style: AppStyle.kRegular20),
                  const SizedBox(height: 4),
                  TekTextField(
                    hint: 'Enter your email',
                    validator: (value) {
                      return widget.validationHelper.validateEmail(value!);
                    },
                    inputController: widget.controller.email,
                  ),
                  const SizedBox(height: 20),
                  Text('Password', style: AppStyle.kRegular20),
                  const SizedBox(height: 4),
                  Consumer(
                    builder: (context, ref, child) {
                      return TekTextField(
                        hint: '********',
                        obscureText: ref.watch(hidePasswordProvider),
                        keyboardType: TextInputType.visiblePassword,
                        onPressedSuffixIcon: () {
                          ref.read(hidePasswordProvider.notifier).state =
                              !ref.read(hidePasswordProvider.notifier).state;
                        },
                        inputController: widget.controller.password,
                        validator: (value) {
                          return widget.validationHelper
                              .validatePassword(value!);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, resetPassword),
                      child: Text(
                        'Forgot your password?',
                        style: AppStyle.kRegular12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Consumer(builder: (context, ref, child) {
                    return TekElevatedButton(
                      child: ref.watch(signInProvider)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Sign In',
                              style: AppStyle.kRegular16,
                            ),
                      onPressed: () {
                        if (widget.controller.formKey.currentState!
                            .validate()) {
                          ref.read(signInProvider.notifier).signInWithEmail(
                                email: widget.controller.email.text.trim(),
                                password:
                                    widget.controller.password.text.trim(),
                              );
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, signup),
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: AppStyle.kRegular12,
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: GoogleFonts.dmSerifDisplay(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
