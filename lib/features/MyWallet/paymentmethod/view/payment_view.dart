import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project11/features/MyWallet/paymentmethod/viewmodel/payment_viewmodel.dart';
import 'package:flutter_project11/features/MyWallet/paymentsucess/view/paymentsuccess_view.dart';
import 'package:provider/provider.dart';

class PaymentMethodView extends StatelessWidget {
  final String amount;

  const PaymentMethodView({super.key, required this.amount});

  static const green = Color(0xff009640);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentMethodViewModel(amount),
      child: Consumer<PaymentMethodViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              titleSpacing: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xFFF3F4F6),
                  child: Icon(Icons.arrow_back_ios_new, size: 13, color: Colors.black),
                ),
              ),
              title: const Text(
                'Payment Method',
                style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w700, fontSize: 17),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            decoration: boxStyle(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Amount to be added',
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                                Text('₹$amount',
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: green)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: boxStyle(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Select Payment method',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 12),
                                methodTile(vm, 0),
                                methodTile(vm, 1),
                              ],
                            ),
                          ),

                          if (vm.selectedMethod == 1) ...[
                            const SizedBox(height: 16),
                            cardForm(vm),
                          ],
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          if (vm.canPay()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PaymentSuccessView()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          'Pay ₹$amount',
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cardForm(PaymentMethodViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: boxStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputField(
            label: 'Card Number*',
            hint: 'Enter Card Number',
            controller: vm.cardController,
            error: vm.cardError,
            onChanged: vm.onCardChanged,
            formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)],
          ),
          inputField(
            label: 'Expiry Date*',
            hint: 'MM/YYYY',
            controller: vm.expiryController,
            error: vm.expiryError,
            onChanged: vm.onExpiryChanged,
            formatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')), LengthLimitingTextInputFormatter(7)],
          ),
          inputField(
            label: 'CVV*',
            hint: 'XXX',
            controller: vm.cvvController,
            error: vm.cvvError,
            onChanged: vm.onCvvChanged,
            formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          ),
        ],
      ),
    );
  }

  Widget inputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? error,
    required Function(String) onChanged,
    required List<TextInputFormatter> formatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: error != null ? Colors.red : const Color(0xFFD1D5DB),
                width: 1.2,
              ),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              inputFormatters: formatters,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF6B7280)),
              ),
            ),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }

  Widget methodTile(PaymentMethodViewModel vm, int index) {
    final item = vm.methods[index];
    final selected = vm.selectedMethod == index;

    return GestureDetector(
      onTap: () => vm.selectMethod(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? green : const Color(0xFFD1D5DB),
            width: selected ? 1.5 : 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F5EC),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(item['icon'] as IconData, size: 15, color: Colors.black),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'] as String,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 3),
                  Text(item['subtitle'] as String,
                      style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                ],
              ),
            ),
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected ? green : const Color(0xFF4B5563), width: 1.8),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(color: green, shape: BoxShape.circle),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6, offset: Offset(0, 2))],
    );
  }
}