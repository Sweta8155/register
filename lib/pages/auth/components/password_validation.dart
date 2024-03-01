import 'package:flutter/material.dart';

class PasswordValidation extends StatelessWidget {
  const PasswordValidation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PasswordValidation();
  }


  // Function to validate the password
  static String?  passwordValidation(String? password) {
    if(password != null && password.isNotEmpty) {
      // Reset error message
      String errorMessage = '';
      // Password length greater than 6
      if (password.length < 6) {
        errorMessage += 'Password must be longer than 6 characters.\n';
      }

      // Contains at least one uppercase letter
      if (!password.contains(RegExp(r'[A-Z]'))) {
        errorMessage += '• Uppercase letter is missing.\n';
      }

      // Contains at least one lowercase letter
      if (!password.contains(RegExp(r'[a-z]'))) {
        errorMessage += '• Lowercase letter is missing.\n';
      }

      // Contains at least one digit
      if (!password.contains(RegExp(r'[0-9]'))) {
        errorMessage += '• Digit is missing.\n';
      }

      // Contains at least one special character
      if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
        errorMessage += '• Special character is missing.\n';
      }
      return errorMessage.isNotEmpty ? errorMessage : null;
    }
    return 'Password is required';
  }
}

