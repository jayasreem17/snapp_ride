import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project11/features/MyWallet/addmoney/viewmodel/addmoney_viewmodel.dart';
import 'package:flutter_project11/features/MyWallet/paymentmethod/view/payment_view.dart';
import 'package:provider/provider.dart';

class AddMoneyView extends StatelessWidget {
  const AddMoneyView({super.key});

  static const green = Color(0xff009640);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddMoneyViewModel(),
      child: Consumer<AddMoneyViewModel>(
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
                'Add Money',
                style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w700, fontSize: 17),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Amount',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF444444)),
                    ),
                    const SizedBox(height: 10),

                    // Amount field
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFD1D5DB), width: 1.2),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.currency_rupee, size: 20, color: Color(0xFF111827)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: vm.amountController,
                              onChanged: vm.onAmountChanged,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(fontSize: 12, color: Color(0xFF444444), fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    Wrap(
                      spacing: 10,
                      children: vm.quickAmounts.entries.map((item) {
                        final selected = vm.amountController.text == item.value;
                        return GestureDetector(
                          onTap: () => vm.selectAmount(item.value),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: selected ? const Color(0xFFE6F5EC) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: selected ? green : const Color(0xFF111827), width: 1.2),
                            ),
                            child: Text(
                              item.key,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: selected ? green : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const Spacer(),

                    
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          if (vm.isValid()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentMethodView(amount: vm.amountController.text),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter a valid amount')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}