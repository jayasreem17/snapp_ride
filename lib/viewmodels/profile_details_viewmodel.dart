import 'package:flutter/material.dart';

class ProfileDetailsViewModel extends ChangeNotifier {
  final String title = 'Profile Details';

  final List<List<String>> details = const [
    ['Full name', 'Arjun'],
    ['Mobile Number', '999088721'],
    ['Emergency Number', '6301234567'],
    ['Gender', 'Male'],
    ['Email Address', 'arjunaryan@123'],
  ];

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}