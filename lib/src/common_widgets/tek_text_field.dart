import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volun_tek/src/constants/colors.dart';

// Custom text field widget
class TekTextField extends StatelessWidget {
  const TekTextField({
    Key? key,
    this.inputController, // Controller for text input
    this.hint, // Hint text for the text field
    this.initialValue, // Initial value of the text field
    this.focusNode, // Focus node for managing focus
    this.keyboardType, // Keyboard type for input
    this.maxLines, // Maximum number of lines for multi-line text field
    this.enabled, // Whether the text field is enabled
    this.validator, // Validator function for input validation
    this.obscureText =
        false, // Whether the text is obscured (e.g., for password input)
    this.onChanged, // Callback function when the text changes
    this.onPressedSuffixIcon, // Callback function when the suffix icon is pressed
  }) : super(key: key);

  final TextEditingController? inputController;
  final String? hint;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool? enabled;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  final VoidCallback? onPressedSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode
          .onUserInteraction, // Autovalidate mode for validation
      initialValue: initialValue,
      focusNode: focusNode,
      keyboardType: keyboardType,
      controller: inputController,
      validator: validator, // Validator function for input validation
      onChanged: onChanged,
      maxLines: maxLines ?? 1,
      enabled: enabled,
      obscureText: obscureText,
      inputFormatters: [
        // Input formatters for filtering text input
        FilteringTextInputFormatter.deny(RegExp('\t')),
      ],
      decoration: InputDecoration(
        // Decoration for the text field
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        suffixIcon: keyboardType == TextInputType.visiblePassword
            ? IconButton(
                // Suffix icon for password visibility toggle
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: kBlue,
                ),
                onPressed:
                    onPressedSuffixIcon, // Callback function when the suffix icon is pressed
              )
            : const SizedBox.shrink(),
        hintText: hint,
        filled: true,
        fillColor: kGray85,
        focusedBorder: const OutlineInputBorder(
          // Border when the text field is focused
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 2.12,
            color: kBlue,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          // Border when the text field is enabled but not focused
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 0,
            color: kPaleBlue,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          // Border when the text field is disabled
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 0,
            color: kBlue,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          // Border when there's an error in the text field
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 2.12,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          // Border when there's an error in the text field and it's focused
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 2.12,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
