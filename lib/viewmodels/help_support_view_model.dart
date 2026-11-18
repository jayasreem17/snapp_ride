import 'package:flutter/material.dart';

class SupportOption {
  final String title;
  final String value;
  final IconData icon;

  const SupportOption(this.title, this.value, this.icon);
}

class HelpSupportViewModel extends ChangeNotifier {
  final String title = 'Help & Support';

  final List<SupportOption> options = const [
    SupportOption('Email Support', 'support@snappride.com', Icons.mail_outline),
    SupportOption('Phone Support', '+91 1800 XXXX XXXX', Icons.call_outlined),
  ];

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}