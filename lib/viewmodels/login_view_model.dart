
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  String? emailError;
  String? passwordError;

  void onEmailChanged(String value) {
    emailError = null;
    notifyListeners();
  }

  void onPasswordChanged(String value) {
    passwordError = null;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  bool validateLogin() {
    bool isValid = true;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      emailError = 'Please enter email address';
      isValid = false;
    } else if (!RegExp(
      r'^[\w.+-]+@[\w-]+\.[\w.-]+$',
    ).hasMatch(email)) {
      emailError = 'Enter valid email address';
      isValid = false;
    } else {
      emailError = null;
    }

    if (password.isEmpty) {
      passwordError = 'Please enter password';
      isValid = false;
    } else if (password.length < 6) {
      passwordError = 'Password must be at least 6 characters';
      isValid = false;
    } else {
      passwordError = null;
    }

    notifyListeners();
    return isValid;
  }

  void login(BuildContext context) {
    if (validateLogin()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful'),
          backgroundColor: Color(0xFF009640),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
