import 'package:flutter/material.dart';
import 'package:flutter_project11/features/completeridehistory/paymentdetails/view/payment_details_view.dart';
import 'package:flutter_project11/features/completeridehistory/rating/view/rating_details_view.dart';
import 'package:flutter_project11/features/completeridehistory/report/view/report_details_view.dart';


class RideDetailsViewModel {
  final Map<String, dynamic> ride;

  RideDetailsViewModel(this.ride);

  bool get isCancelled => ride['status'] == 'Cancelled';
  String get title => ride['title'];
  String get status => ride['status'];
  String get image => ride['image'];
  String get date => ride['date'];
  int get amount => ride['amount'];
  int get points => ride['points'];
  int get walletRupees => points ~/ 2;
  String get rideId => 'SNP1234';
  String get address => 'Madhapur, Analogue IT Solutions, Hyderabad, Telangana';

  void goToPayment(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentDetailsView(ride: ride)));
  }

  void goToReport(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportView()));
  }

  void goToRating(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const DriverRatingView()));
  }
}