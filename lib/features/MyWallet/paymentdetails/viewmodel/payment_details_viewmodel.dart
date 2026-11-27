import 'package:flutter/material.dart';

class PaymentDetailsViewModel {
  final String detailsKey;

  PaymentDetailsViewModel(this.detailsKey);

  Map<String, List<List<String>>> get sections => _details[detailsKey] ?? {};

  bool get hasHelpButton => sections.containsKey('Refund Status');

  bool isTotal(String label) {
    return label == 'Total Amount';
  }

  String formatDate(String dateTime) {
    final date = dateTime.split('|').first.trim();
    final parts = date.split(' ');
    if (parts.length != 3) return date;
    return '${parts[0]} ${parts[1]},${parts[2]}';
  }

  IconData get icon {
    if (detailsKey == 'Referral Money') return Icons.person_add_alt_outlined;
    if (detailsKey == 'Add Money') return Icons.add;
    if (detailsKey == 'Bike Ride') return Icons.two_wheeler;
    return Icons.account_balance_wallet_outlined;
  }

  void onBack(BuildContext context) {
    Navigator.pop(context);
  }

  void onDownloadInvoice() {}

  void onHelpSupport() {}

  static const String refundNote =
      'Your refund will be credited to your Snapp Ride Wallet within 24 hours.';

  static const Map<String, Map<String, List<List<String>>>> _details = {
    'Pending: Pending Payment Refund': {
      'Fare Summary': [
        ['Distance Charges (5.2 km)', '₹80.00'],
        ['Previous Cancellation Charges', '₹0'],
        ['Total Amount', '₹80.00'],
      ],
      'Payment Summary': [
        ['Payment Method', 'Razor Pay'],
        ['Payment Status', 'Successful'],
        ['Transaction ID', 'SNP123456R'],
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
      'Refund Summary': [
        ['Refund Amount', '₹80'],
        ['Refund Method', 'Sanpp Ride Wallet'],
      ],
      'Refund Status': [
        [refundNote],
        ['Refund Status', 'Processing'],
      ],
    },
    'Pending: Ride Refund Money': {
      'Fare Summary': [
        ['Amount Paid (5.2 km)', '₹100.00'],
        ['Previous Cancellation Charges', '-₹20.00'],
        ['Travelled Distance Charges (3.2 km)', '-₹60.00'],
        ['Waiting Charges', '₹0'],
        ['Total Amount', '₹20.00'],
      ],
      'Payment Summary': [
        ['Payment Method', 'Razor Pay'],
        ['Payment Status', 'Successful'],
        ['Transaction ID', 'SNP123456R'],
        ['Date', '11 Oct, 2026'],
        ['Time', '10:30 AM'],
      ],
      'Refund Summary': [
        ['Refund Amount', '₹20'],
        ['Refund Method', 'Sanpp Ride Wallet'],
      ],
      'Refund Status': [
        [refundNote],
        ['Refund Status', 'Processing'],
      ],
    },
    'Pending Payment Refund': {
      'Fare Summary': [
        ['Distance Charges (5.2 km)', '₹120.00'],
        ['Waiting Charges', '₹0'],
        ['Additional Ride Charges', '₹0'],
        ['Total Amount', '₹120.00'],
      ],
      'Payment Summary': [
        ['Payment Method', 'Razor Pay'],
        ['Payment Status', 'Successful'],
        ['Transaction ID', 'SNP123456R'],
        ['Date', '11 Oct, 2026'],
        ['Time', '10:30 AM'],
      ],
      'Refund Summary': [
        ['Refund Amount', '₹120'],
        ['Refund Method', 'Sanpp Ride Wallet'],
        ['Refund Status', 'Successful'],
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
    'Snapp Ride Bonus': {
      'Earnings Summary': [
        ['Total Rids', '20'],
        ['Bonus Amount', '₹200.00'],
        ['Total Amount', '₹200.00'],
      ],
      'Details': [
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
    'Ride Refund Money': {
      'Fare Summary': [
        ['Paid Amount (5.2 km)', '₹100.00'],
        ['Previous Cancellation Charges', '-₹20.00'],
        ['Travelled Distance Charges (3.2 km)', '-₹60.00'],
        ['Waiting Charges', '₹0'],
        ['Total Amount', '₹20.00'],
      ],
      'Payment Summary': [
        ['Payment Method', 'Razor Pay'],
        ['Payment Status', 'Successful'],
        ['Transaction ID', 'SNP123456R'],
        ['Date', '11 Oct, 2026'],
        ['Time', '10:30 AM'],
      ],
      'Refund Summary': [
        ['Refund Amount', '₹20'],
        ['Refund Method', 'Sanpp Ride Wallet'],
        ['Refund Status', 'Successful'],
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
    'Ride Points Money': {
      'Earnings Summary': [
        ['Fare Amount', '₹120.00'],
        ['Ride Points', '10'],
        ['Points Money', '₹5'],
        ['Total Amount', '₹5.00'],
      ],
      'Ride Summary': [
        ['Ride Type', 'Passenger'],
        ['Ride Service', 'Bike'],
        ['Ride ID', 'SNP123456R'],
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
    'Parcel Ride Points Money': {
      'Earnings Summary': [
        ['Fare Amount', '₹120.00'],
        ['Ride Points', '10'],
        ['Points Money', '₹5'],
        ['Total Amount', '₹5.00'],
      ],
      'Ride Summary': [
        ['Ride Type', 'Parcel'],
        ['Ride Service', 'Bike'],
        ['Ride ID', 'SNP123456R'],
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
    'Referral Money': {
      'Earnings Summary': [
        ['Referral Points', '50'],
        ['Points Money', '₹50'],
        ['Total Amount', '₹50.00'],
      ],
      'Details': [
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
    'Add Money': {
      '': [
        ['Amount to be added', '₹200'],
      ],
      'Details': [
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
    'Bike Ride': {
      'Fare Summary': [
        ['Distance Charges (5.2 km)', '₹80.00'],
        ['Waiting Charges', '+₹20.00'],
        ['Additional Ride Charges', '+₹20.00'],
        ['Wallet Amount', '-₹20.00'],
        ['Total Amount', '₹100.00'],
      ],
      '': [
        ['Wallet Amount', '₹20'],
      ],
      'Payment Summary': [
        ['Payment Method', 'Razor Pay + Wallet'],
        ['Payment Status', 'Successful'],
        ['Transaction ID', 'SNP123456R'],
        ['Date', '12 Oct, 2026'],
        ['Time', '12:00 PM'],
      ],
    },
  };
}