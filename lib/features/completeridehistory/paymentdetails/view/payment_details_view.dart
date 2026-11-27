
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project11/features/completeridehistory/paymentdetails/viewmodel/payment_details_viewmodel.dart';

const Color _green = Color(0xFF009640);
const Color _orange = Color(0xFFF08A00);

class PaymentDetailsView extends StatelessWidget {
  final Map<String, dynamic> ride;

  const PaymentDetailsView({super.key, required this.ride});

  Widget _row(String label, String value, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700)),
          Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Widget _total(String value) {
    return Column(
      children: [
        const SizedBox(height: 6),
        const Divider(height: 1),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total Amount', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
            Text(value, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: _green)),
          ],
        ),
      ],
    );
  }

  Widget _card(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE3E3E3)),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
         
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentDetailsViewModel(ride),
      child: Consumer<PaymentDetailsViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              titleSpacing: 0,
              leading: Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF9F7F7),
                    ),
                    child: const Icon(Icons.chevron_left, size: 20, color: Colors.black),
                  ),
                ),
              ),
              title: const Text(
                'Payment Details',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (vm.isCancelled) ...[
                          Text(vm.date, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFEDEDED)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: const Color(0xFFE3E3E3)),
                                  ),
                                  child: const Icon(Icons.currency_rupee, size: 14, color: _green),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Flexible(
                                            child: Text('Ride Refund Money', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                                          ),
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFC40000),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Text('Pending', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Text('${vm.date} | ${vm.time}', style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text('₹20', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _orange)),
                                    const SizedBox(height: 2),
                                    Text('Razor Pay', style: TextStyle(fontSize: 8.5, color: Colors.grey.shade600)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          _card('Fare Summary', [
                            _row('Paid Amount', '₹${vm.amount}.00'),
                            _row('Previous Cancellation Charges', '-₹20.00'),
                            _row('Distance Charges (3.2 km)', '-₹${vm.cancelledDistance}.00'),
                            _row('Waiting Charges', '₹0'),
                            _total('₹20.00'),
                          ]),
                          _card('Payment Summary', [
                            _row('Payment Method', 'Razor Pay'),
                            _row('Payment Status', 'Successful'),
                            _row('Transaction ID', 'SNP123456R'),
                            _row('Date', vm.date),
                            _row('Time', vm.time),
                          ]),
                          _card('Refund Summary', [
                            _row('Refund Amount', '₹20'),
                            _row('Refund Method', 'Snapp Ride Wallet'),
                          ]),
                          _card('Refund Status', [
                            Text(
                              'Your refund will be credited to your Snapp Ride Wallet within 24 hours.',
                              style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600, height: 1.4),
                            ),
                            const SizedBox(height: 6),
                            _row('Refund Status', 'Processing', color: _orange),
                          ]),
                        ] else ...[
                          _card('Fare Summary', [
                            _row('Distance Charges (5.2 km)', '+₹${vm.completedDistance}.00'),
                            _row('Previous Cancellation Charges', '+₹20.00'),
                            _row('Wallet Amount', '-₹10.00'),
                            _row('Additional Charges', '+₹40.00'),
                            _total('₹${vm.amount}.00'),
                          ]),
                          _card('Additional Charges', [
                            _row('Waiting Charges', '₹20.00'),
                            _row('Additional Ride Charges', '₹20.00'),
                            _row('Payment Method', 'Razor Pay'),
                            _row('Transaction ID', 'SNP123456R'),
                            _row('Payment Status', 'Successful'),
                            _row('Time', '11:02 AM'),
                          ]),
                          _card('Fare Payment Summary', [
                            _row('Payment Method', 'Razor Pay+ Wallet'),
                            _row('Payment Status', 'Successful'),
                            _row('Transaction ID', 'SNP123456R'),
                            _row('Date', vm.date),
                            _row('Time', vm.time),
                          ]),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () => vm.downloadInvoice(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _green,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'Download Invoice',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),
                      ),
                      if (vm.isCancelled) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: OutlinedButton(
                            onPressed: () => vm.openHelp(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: _green),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Help & Support',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _green),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
