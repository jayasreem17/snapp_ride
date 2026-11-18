import 'package:flutter/material.dart';

class FaqItem {
  final String question;
  final String answer;

  const FaqItem(this.question, this.answer);
}

class HelpCenterViewModel extends ChangeNotifier {
  final String title = 'Help Center';

  final List<FaqItem> faqs = const [
    FaqItem(
      'Where is my driver?',
      'Once a driver is assigned, open your active ride to view the driver\'s location, estimated arrival time, and trip progress. If the location is temporarily unavailable, check the last updated time. If the issue continues, contact support.',
    ),
    FaqItem('How can I cancel my ride?', ''),
    FaqItem('I was charged, but my payment is still pending. What should I do?',
        ''),
    FaqItem('How can I check my refund status?', ''),
    FaqItem('How can I report a driver or safety issue?', ''),
    FaqItem('How do I add money to my wallet?', ''),
  ];

  int? _expandedIndex = 0;
  int? get expandedIndex => _expandedIndex;

  void toggle(int index) {
    _expandedIndex = _expandedIndex == index ? null : index;
    notifyListeners();
  }

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}