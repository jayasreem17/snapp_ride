import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReferralHistoryItem {
  final String title;
  final String date;
  final String points;
  final String note;

  const ReferralHistoryItem(this.title, this.date, this.points, this.note);
}

class ReferAndEarnViewModel extends ChangeNotifier {
  final String title = 'Refer & Earn';
  final String earnLabel = 'Earn 50 Points';
  final String referralCode = 'AJ126332IQ';
  final int referrals = 4;
  final int points = 200;
  final String totalEarnings = '₹100.00';

  final List<ReferralHistoryItem> history = const [
    ReferralHistoryItem(
        'Referral Money', '12 Oct 2026', '+₹50 Points', 'Credit in Wallet'),
    ReferralHistoryItem(
        'Referral Money', '12 Oct 2026', '+₹50 Points', 'Credit in Wallet'),
    ReferralHistoryItem(
        'Referral Money', '12 Oct 2026', '+₹50 Points', 'Credit in Wallet'),
    ReferralHistoryItem(
        'Referral Money', '12 Oct 2026', '+₹50 Points', 'Credit in Wallet'),
  ];

  void copyCode() {
    Clipboard.setData(ClipboardData(text: referralCode));
  }

  void goBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }
}