import 'package:flutter/material.dart';

class PaymentDetailsViewModel {
  final Map<String, dynamic> ride;

  PaymentDetailsViewModel(this.ride);

  bool get isCancelled => ride['status'] == 'Cancelled';
  int get amount => ride['amount'];
  String get date => ride['date'];
  String get time => ride['time'];
  int get completedDistance => amount - 50;
  int get cancelledDistance => amount - 40;

  void downloadInvoice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF009640),
        content: Text('Invoice downloaded'),
      ),
    );
  }

  void openHelp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening Help & Support')),
    );
  }
}