// Method to validate email field
class ValidationHelper {
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Please enter your email";
    } else if (!value.contains('@')) {
      return "Please enter a valid email";
    }
    return null;
  }

  // Method to validate general text field
  String? validateField(String value) {
    if (value.length < 4) {
      return "Field must be more than 4 characters ";
    }
    return null;
  }

  // Method to validate password field
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Enter a valid password";
    } else if (value.length < 8) {
      return " Password must be at least 8 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    return null;
  }

  // Method to validate second password field
  String? validatePassword2(String value, String value2) {
    if (value.isEmpty) {
      return "Enter a valid password";
    } else if (value.length < 8) {
      return " Password must be at least 8 characters";
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    } else if (value != value2) {
      return "Passwords do not match";
    }
    return null;
  }
}
