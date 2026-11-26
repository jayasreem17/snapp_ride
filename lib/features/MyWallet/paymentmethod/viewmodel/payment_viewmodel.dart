
import 'package:flutter/material.dart';

class PaymentMethodViewModel extends ChangeNotifier {
  final String amount;

  PaymentMethodViewModel(this.amount);

  int selectedMethod = 0;

  final cardController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  String? cardError;
  String? expiryError;
  String? cvvError;

  final methods = [
    {
      'icon': Icons.qr_code_2,
      'title': 'UPI Payment',
      'subtitle': 'Pay instantly using UPI',
    },
    {
      'icon': Icons.credit_card,
      'title': 'Credit / Debit Card',
      'subtitle': 'Enter card details',
    },
  ];

  void selectMethod(int index) {
    selectedMethod = index;
    cardError = null;
    expiryError = null;
    cvvError = null;
    notifyListeners();
  }

  void onCardChanged(String value) {
    cardError = null;
    notifyListeners();
  }

  void onCvvChanged(String value) {
    cvvError = null;
    notifyListeners();
  }

  void onExpiryChanged(String value) {
    expiryError = null;

    String digits = value.replaceAll('/', '');

    if (digits.length > 2) {
      digits = '${digits.substring(0, 2)}/${digits.substring(2)}';
    }

    if (digits != value) {
      expiryController.value = TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(
          offset: digits.length,
        ),
      );
    }

    notifyListeners();
  }

  String? checkCard() {
    final text = cardController.text.trim();

    if (text.isEmpty) return 'Please enter Card Number';
    if (text.length != 16) return 'Card Number must be 16 digits';

    return null;
  }

  String? checkExpiry() {
    final text = expiryController.text.trim();

    if (text.isEmpty) return 'Please enter Expiry Date';

    final parts = text.split('/');

    if (parts.length != 2 ||
        parts[0].length != 2 ||
        parts[1].length != 4) {
      return 'Use MM/YYYY format';
    }

    final month = int.tryParse(parts[0]) ?? 0;
    final year = int.tryParse(parts[1]) ?? 0;

    if (month < 1 || month > 12) {
      return 'Enter a valid month';
    }

    final now = DateTime.now();

    if (year < now.year ||
        (year == now.year && month < now.month)) {
      return 'Card has expired';
    }

    return null;
  }

  String? checkCvv() {
    final text = cvvController.text.trim();

    if (text.isEmpty) return 'Please enter CVV';
    if (text.length != 3) return 'CVV must be 3 digits';

    return null;
  }

  bool canPay() {
    if (selectedMethod == 0) return true;

    cardError = checkCard();
    expiryError = checkExpiry();
    cvvError = checkCvv();

    notifyListeners();

    return cardError == null &&
        expiryError == null &&
        cvvError == null;
  }

  @override
  void dispose() {
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}
