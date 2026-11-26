import 'package:flutter/material.dart';
import 'package:flutter_project11/features/MyWallet/yourwallet/view/your_wallet_view.dart';

class PaymentSuccessViewModel extends ChangeNotifier {
  final String title = 'Payment Successful!';
  final String message = 'Amount added to your wallet successfully.';

  void onOkay(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void onViewWallet(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const YourWalletView()),
      (route) => route.isFirst,
    );
  }
}