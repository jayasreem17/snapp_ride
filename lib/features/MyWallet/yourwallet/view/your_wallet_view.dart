import 'package:flutter/material.dart';
import 'package:flutter_project11/features/MyWallet/addmoney/view/addmoney_view.dart';
import 'package:flutter_project11/features/MyWallet/earninghistory/view/earning_history_view.dart';
import 'package:flutter_project11/features/MyWallet/yourwallet/viewmodel/your_wallet_viewmodel.dart';
import 'package:provider/provider.dart';

class YourWalletView extends StatelessWidget {
  const YourWalletView({super.key});

  static const green = Color(0xff009640);
  static const lightGreen = Color(0xFFE6F5EC);
  static const lightRed = Color(0xFFFDECEC);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WalletViewModel(),
      child: Consumer<WalletViewModel>(
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
                'Your Wallet',
                style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600, fontSize: 17),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                children: [
            
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 92,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF00A745), Color(0xFF007D35)],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(painter: CurvePainter()),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Current Balance', style: TextStyle(color: Colors.white, fontSize: 11)),
                                      const SizedBox(height: 4),
                                      Text('₹${vm.balance.toStringAsFixed(2)}',
                                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      const Text('Use Wallet amount for rides', style: TextStyle(color: Colors.white, fontSize: 8)),
                                    ],
                                  ),
                                ),
                                Image.asset('assets/images/objects.png', height: 56, width: 56),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

        
                  Row(
                    children: [
                      Expanded(child: amountCard('Credited', '₹${vm.credited.toStringAsFixed(2)}', Icons.login, green, lightGreen)),
                      const SizedBox(width: 10),
                      Expanded(child: amountCard('Debited', '₹${vm.debited.toStringAsFixed(2)}', Icons.logout, Colors.red, lightRed)),
                    ],
                  ),
                  const SizedBox(height: 10),

            
                  GestureDetector(
                onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AddMoneyView()),
  );
},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: boxStyle(),
                      child: const Column(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: lightGreen,
                            child: Icon(Icons.add, color: green, size: 16),
                          ),
                          SizedBox(height: 6),
                          Text('Add Money', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.black, Color(0xFF005C2B), green]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.white, fontSize: 11),
                                children: [
                                  TextSpan(text: '${vm.points} ', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                  const TextSpan(text: 'Points'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('₹10 added in Wallet', style: TextStyle(color: Colors.white, fontSize: 8)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                              child: const Icon(Icons.two_wheeler, color: Colors.black, size: 12),
                            ),
                            const SizedBox(height: 4),
                            const Text('10 Points = 5 rupees', style: TextStyle(color: Colors.white, fontSize: 8)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

            
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF00A745), Color(0xFF008A3A)]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                      
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: const Color(0x33D9D9D9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: const Center(
                                child: Text(
                                  '₹',
                                  style: TextStyle(color: green, fontSize: 22, fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${vm.referrals} Referrals', style: const TextStyle(color: Colors.white, fontSize: 9)),
                              const SizedBox(height: 3),
                              Text('${vm.referrals * 50} Points',
                                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 3),
                              const Text('10 Points = 5 rupees', style: TextStyle(color: Colors.white, fontSize: 7)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('Total Earnings', style: TextStyle(color: Colors.white, fontSize: 9)),
                            const SizedBox(height: 3),
                            Text('₹${vm.totalEarnings.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 3),
                            const Text('Added in Wallet', style: TextStyle(color: Colors.white, fontSize: 7)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

            
                  Row(
                    children: [
                      tab('Earnings History', 0, 11, vm),
                      tab('Pending Refunds', 1, 9, vm),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const BoxDecoration(
                                border: Border(top: BorderSide(color: Color(0xFF111827), width: 2)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search, size: 16, color: Color(0xFF111827)),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: TextField(
                                      controller: vm.searchController,
                                      onChanged: vm.onSearchChanged,
                                      style: const TextStyle(fontSize: 11, color: Colors.black),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: vm.selectedDate ?? 'Search Location, date',
                                        hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                                      ),
                                    ),
                                  ),
                                  if (vm.selectedDate != null)
                                    GestureDetector(
                                      onTap: vm.clearDate,
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 6),
                                        child: Icon(Icons.close, size: 14, color: Colors.red),
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap: () => vm.pickDate(context),
                                    child: const Icon(Icons.calendar_month_outlined, size: 16, color: Color(0xFF111827)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => vm.openFilter(context),
                        child: Icon(
                          Icons.tune,
                          size: 20,
                          color: vm.filterType == 'All' ? const Color(0xFF111827) : green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Transaction list
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: boxStyle(),
                    child: vm.transactions.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(25),
                            child: Center(child: Text('No transactions found', style: TextStyle(fontSize: 12))),
                          )
                        : Column(
                            children: vm.transactions.map((item) {
                              return Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: lightGreen,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(item['icon'], size: 14, color: Colors.black87),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(item['title'],
                                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight(600))),
                                              if (item['badge'] != '')
                                                Container(
                                                  margin: const EdgeInsets.only(left: 6),
                                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(204, 255, 251, 250),
                                                    borderRadius: BorderRadius.circular(3),
                                                  ),
                                                  child: Text(item['badge'],
                                                      style: const TextStyle(color: Colors.orange, fontSize: 7,fontWeight: FontWeight.bold),
                                                    
                                                      ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(height: 3),
                                          Text(item['date'],
                                              style: const TextStyle(fontSize: 8, color: Color(0xFF6B7280))),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(item['amount'],
                                            style: TextStyle(
                                              color: item['amount'].startsWith('+') ? green : Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            )),
                                        const SizedBox(height: 3),
                                        Text(item['type'],
                                            style: const TextStyle(fontSize: 8, color: Color(0xFF6B7280))),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  const SizedBox(height: 14),
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EarningHistoryView()),
    );
  },
  child: const Text(
    'View All',
    style: TextStyle(color: green, fontWeight: FontWeight.bold, fontSize: 13),
  ),
),                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration boxStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE5E7EB)),
      boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2))],
    );
  }

  Widget amountCard(String title, String amount, IconData icon, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: boxStyle(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFF6B7280), fontSize: 10)),
                const SizedBox(height: 4),
                Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
              boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Icon(icon, color: color, size: 10),
          ),
        ],
      ),
    );
  }

  Widget tab(String text, int index, int flex, WalletViewModel vm) {
    final selected = vm.selectedTab == index;
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => vm.changeTab(index),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: selected ? green : Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 2, color: selected ? Colors.black : Colors.transparent),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w * 0.55, h)
      ..cubicTo(w * 0.58, h * 0.80, w * 0.62, h * 0.50, w * 0.72, h * 0.48)
      ..cubicTo(w * 0.80, h * 0.46, w * 0.86, h * 0.60, w * 0.92, h * 0.40)
      ..cubicTo(w * 0.95, h * 0.30, w * 0.98, h * 0.34, w, h * 0.30)
      ..lineTo(w, h)
      ..close();

    canvas.drawPath(path, Paint()..color = const Color(0xFF1FA155));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}