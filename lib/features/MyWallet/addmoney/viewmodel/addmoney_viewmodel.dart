import 'package:flutter/material.dart';

class AddMoneyViewModel extends ChangeNotifier {
  final amountController = TextEditingController();

  final quickAmounts = {
    '₹100': '100',
    '₹200': '200',
    '₹500': '500',
    '₹1,000': '1000',
  };

  void selectAmount(String value) {
    amountController.text = value;
    notifyListeners();
  }

  void onAmountChanged(String value) {
    notifyListeners();
  }

  bool isValid() {
    final amount = int.tryParse(amountController.text) ?? 0;
    return amount > 0;
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}