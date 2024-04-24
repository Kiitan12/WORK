import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:volun_tek/src/routing/routes.dart';

import '../../../../common_widgets/tek_elevated_button.dart';
import '../../../../common_widgets/tek_text_field.dart';
import '../../../../constants/app_style.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/validation_helper.dart';
import '../controller/sign_up_controller.dart';
import '../provider/sign_up_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
    required this.validationHelper,
    required this.controller,
  });

  final ValidationHelper validationHelper;
  final SignUpController controller;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: AppStyle.kHeading1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28, bottom: 20),
        child: SingleChildScrollView(
          child: Form(
            key: widget.controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/signup.png',
                    height: 198,
                    alignment: Alignment.center,
                  ),
                ),
                const SizedBox(height: 12),
                Text('Name', style: AppStyle.kRegular20),
                const SizedBox(height: 4),
                TekTextField(
                  inputController: widget.controller.name,
                  validator: (value) {
                    return widget.validationHelper.validateField(value!);
                  },
                ),
                const SizedBox(height: 20),
                Text('Email', style: AppStyle.kRegular20),
                const SizedBox(height: 4),
                TekTextField(
                  inputController: widget.controller.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return widget.validationHelper.validateEmail(value!);
                  },
                ),
                const SizedBox(height: 20),
                Text('Password', style: AppStyle.kRegular20),
                const SizedBox(height: 4),
                Consumer(builder: (context, ref, child) {
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
                      return widget.validationHelper.validatePassword(value!);
                    },
                    onChanged: (value) {
                      ref.read(passwordMismatchProvider.notifier).state = value;
                    },
                  );
                }),
                const SizedBox(height: 20),
                Text('Confirm Password', style: AppStyle.kRegular20),
                const SizedBox(height: 4),
                Consumer(builder: (context, ref, child) {
                  return TekTextField(
                      hint: '********',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: ref.watch(hidePasswordProvider),
                      onPressedSuffixIcon: () {
                        ref.read(hidePasswordProvider.notifier).state =
                            !ref.read(hidePasswordProvider.notifier).state;
                      },
                      inputController: widget.controller.password2,
                      validator: (value) {
                        return widget.validationHelper.validatePassword2(
                          value!,
                          ref.watch(passwordMismatchProvider),
                        );
                      });
                }),
                const SizedBox(height: 32),
                Consumer(
                  builder: (context, ref, child) {
                    return TekElevatedButton(
                      title: 'Sign Up',
                      child: ref.watch(signUpProvider)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Sign Up', style: AppStyle.kRegular16),
                      onPressed: () {
                        if (widget.controller.formKey.currentState!
                            .validate()) {
                          ref.read(signUpProvider.notifier).signUpWithEmail(
                                email: widget.controller.email.text.trim(),
                                password:
                                    widget.controller.password.text.trim(),
                                name: widget.controller.name.text.trim(),
                              );
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: ()=> Navigator.pushNamed(context, login) , // Add this line),
                    child: RichText(
                      text: TextSpan(
                        text: 'Have an account? ',
                        style: AppStyle.kRegular12,
                        children: [
                          TextSpan(
                            text: 'Sign in',
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
