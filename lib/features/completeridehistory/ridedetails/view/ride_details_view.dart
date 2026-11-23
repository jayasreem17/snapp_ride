import 'package:flutter/material.dart';
import 'package:flutter_project11/features/completeridehistory/ridedetails/viewmodel/ride_details_viewmodel.dart';


const Color _green = Color(0xFF009640);
const Color _orange = Color(0xFFF08A00);

class RideDetailsView extends StatelessWidget {
  final Map<String, dynamic> ride;

  const RideDetailsView({super.key, required this.ride});

  Widget _location(String title, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFEDEDED)),
              child: Icon(Icons.location_on_outlined, size: 9, color: Colors.grey.shade600),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(address, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.4)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _boldLabelRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          Text(value, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _boldValueRow(String label, String value, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700)),
          Text(value, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  BoxDecoration _cardBox() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE3E3E3)),
      boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
    );
  }

  @override
  Widget build(BuildContext context) {
    RideDetailsViewModel vm = RideDetailsViewModel(ride);

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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 249, 247, 247),

              ),
              child: const Icon(Icons.chevron_left, size: 20, color: Colors.black),
            ),
          ),
        ),
        title: const Text('Ride Details', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Image.asset(
                    vm.image,
                    width: 32,
                    height: 32,
                    errorBuilder: (c, e, s) => Image.asset('assets/images/bike.png', width: 32, height: 32),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(vm.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: vm.isCancelled ? const Color(0xFFC40000) : _green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(vm.status, style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: Colors.white)),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF1DC),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('${vm.points} Points', style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.w600, color: _orange)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('Ride ID: ${vm.rideId}', style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                  Text('₹${vm.amount}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(
                  colors: [Color(0xFF111111), _green],
                  stops: [0.35, 0.8],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: '${vm.points} ', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _orange)),
                            const TextSpan(text: 'Points', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text('₹${vm.walletRupees} added in Wallet', style: const TextStyle(fontSize: 8.5, color: Colors.white)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                        child: const Icon(Icons.account_balance_wallet_outlined, size: 12),
                      ),
                      const SizedBox(height: 3),
                      const Text('10 Points = 5 rupees', style: TextStyle(fontSize: 8.5, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text('Ride details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: _cardBox(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _location('Pick Up Location', vm.address),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
                  _location('Drop Location', vm.address),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
                  _boldLabelRow('Service Selected', vm.title),
                  _boldLabelRow('Driver Preference', 'Women'),
                  const SizedBox(height: 4),
                  const Text('Payment Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  if (vm.isCancelled) ...[
                    _boldValueRow('Ride Amount', '₹${vm.amount}'),
                    _boldValueRow('Payment Process', 'Pre Payment'),
                    _boldValueRow('Payment Method', 'Razor Pay'),
                    _boldValueRow('Payment Status', 'Successful'),
                    _boldValueRow('Refund Amount', '₹20'),
                    _boldValueRow('Refund Status', 'Pending', color: _orange),
                    _boldValueRow('Refund Method', 'Snapp Ride Wallet'),
                  ] else ...[
                    _boldValueRow('Amount', '₹${vm.amount}'),
                    _boldValueRow('Payment Process', 'Pay Now'),
                    _boldValueRow('Payment Method', 'Razor Pay + Wallet'),
                    _boldValueRow('Payment Status', 'Successful'),
                  ],
                  const SizedBox(height: 4),
                  _boldLabelRow('Ride Status', vm.status),
                ],
              ),
            ),
            if (vm.isCancelled) ...[
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: _cardBox(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Refund Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(
                      'Your refund will be credited to your Snapp Ride Wallet within 24 hours.',
                      style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600, height: 1.4),
                    ),
                    const SizedBox(height: 6),
                    _boldValueRow('Refund Status', 'Processing', color: _orange),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 18),
            const Text('Driver details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: _cardBox(),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 24, backgroundColor: Color(0xFFD9D9D9)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Arjun Kumar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 2),
                            const Row(
                              children: [
                                Icon(Icons.star_border_rounded, size: 14, color: Color(0xFFF5B301)),
                                SizedBox(width: 3),
                                Text('4.8', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text('Top Rated Driver', style: TextStyle(fontSize: 9, color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/bike.png', width: 26, height: 26),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                            child: const Text('TS 09 AB 1234', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                          ),
                          const SizedBox(height: 3),
                          Text('Grey Honda Activa 125', style: TextStyle(fontSize: 8.5, color: Colors.grey.shade600)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: OutlinedButton(
                            onPressed: () => vm.goToReport(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: _green),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('Report', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _green)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: ElevatedButton(
                            onPressed: () => vm.goToRating(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('Give Rating', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton(
                onPressed: () => vm.goToPayment(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _green,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('View Payment Details', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}