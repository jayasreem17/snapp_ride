import 'package:flutter/material.dart';

enum GenderOption { male, female, preferNotToSay }

class EditDetailsViewModel extends ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emergencyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? nameError;
  String? phoneError;
  String? emailError;

  GenderOption _gender = GenderOption.male;
  GenderOption get gender => _gender;

  EditDetailsViewModel() {
    fullNameController.addListener(checkName);
    emergencyController.addListener(checkPhone);
    emailController.addListener(checkEmail);
  }

  void checkName() {
    String v = fullNameController.text;
    if (v.isEmpty) {
      nameError = null;
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(v)) {
      nameError = 'Only letters are allowed';
    } else if (v.trim().length < 3) {
      nameError = 'Enter at least 3 letters';
    } else {
      nameError = null;
    }
    notifyListeners();
  }

  void checkPhone() {
    String v = emergencyController.text;
    if (v.isEmpty) {
      phoneError = null;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
      phoneError = 'Only numbers are allowed';
    } else if (!RegExp(r'^[6-9]').hasMatch(v)) {
      phoneError = 'Number must start with 6, 7, 8 or 9';
    } else if (v.length < 10) {
      phoneError = 'Enter 10 digit mobile number';
    } else {
      phoneError = null;
    }
    notifyListeners();
  }

  void checkEmail() {
    String v = emailController.text.trim();
    if (v.isEmpty) {
      emailError = null;
    } else if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(v)) {
      emailError = 'Enter a valid email address';
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void selectGender(GenderOption value) {
    _gender = value;
    notifyListeners();
  }

  void updateDetails(BuildContext context) {
    FocusScope.of(context).unfocus();

    checkName();
    checkPhone();
    checkEmail();

    if (fullNameController.text.isEmpty) {
      nameError = 'Full name is required';
    }
    if (emergencyController.text.isEmpty) {
      phoneError = 'Emergency number is required';
    }
    notifyListeners();

    if (nameError != null || phoneError != null || emailError != null) return;

    Navigator.of(context).maybePop();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emergencyController.dispose();
    emailController.dispose();
    super.dispose();
  }
}