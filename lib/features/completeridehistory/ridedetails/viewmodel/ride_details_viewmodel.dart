
import 'package:flutter/material.dart';
import 'package:flutter_project11/features/completeridehistory/paymentdetails/view/payment_details_view.dart';
import 'package:flutter_project11/features/completeridehistory/rating/view/rating_details_view.dart';
import 'package:flutter_project11/features/completeridehistory/report/view/report_details_view.dart';

class RideDetailsViewModel extends ChangeNotifier {
  final Map<String, dynamic> ride;

  RideDetailsViewModel(this.ride);

  bool get isCancelled => ride['status'] == 'Cancelled';
  String get title => ride['title']?.toString() ?? '';
  String get status => ride['status']?.toString() ?? '';
  String get image => ride['image']?.toString() ?? 'assets/images/bike.png';
  String get date => ride['date']?.toString() ?? '';
  int get amount => (ride['amount'] as num?)?.toInt() ?? 0;
  int get points => (ride['points'] as num?)?.toInt() ?? 0;
  int get walletRupees => points ~/ 2;
  String get rideId => ride['rideId']?.toString() ?? 'SNP1234';
  String get address => ride['address']?.toString() ?? 'Madhapur, Analogue IT Solutions, Hyderabad, Telangana';

  void goToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentDetailsView(ride: ride),
      ),
    );
  }

  void goToReport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReportView(),
      ),
    );
  }

  void goToRating(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DriverRatingView(),
      ),
    );
  }
}
