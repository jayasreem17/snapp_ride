import 'package:flutter/material.dart';

enum GenderOption { male, female, preferNotToSay }

class EditDetailsViewModel extends ChangeNotifier {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emergencyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  GenderOption _gender = GenderOption.male;
  GenderOption get gender => _gender;

  void selectGender(GenderOption value) {
    _gender = value;
    notifyListeners();
  }

  void updateDetails(BuildContext context) {
    FocusScope.of(context).unfocus();
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