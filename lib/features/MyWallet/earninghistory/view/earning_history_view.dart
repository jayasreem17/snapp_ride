import 'package:flutter/material.dart';
import 'package:flutter_project11/features/MyWallet/earninghistory/viewmodel/earning_history_viewmodel.dart';
import 'package:provider/provider.dart';

class EarningHistoryView extends StatelessWidget {
  const EarningHistoryView({super.key});

  static const green = Color(0xff009640);
  static const lightGreen = Color(0xFFE6F5EC);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EarningHistoryViewModel(),
      child: Consumer<EarningHistoryViewModel>(
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
                'Earnings History',
                style: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600, fontSize: 17),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  // Search bar and filter
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
                                border: Border(top: BorderSide(color: Color(0xFF111827), width: 1)),
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

                  // Transaction list (fills the remaining screen)
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2))],
                      ),
                      child: vm.transactions.isEmpty
                          ? const Center(child: Text('No transactions found', style: TextStyle(fontSize: 12)))
                          : ListView(
                              padding: EdgeInsets.zero,
                              children: vm.transactions.map((item) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          color: lightGreen,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Icon(item['icon'], size: 15, color: Colors.black87),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(item['title'],
                                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                                if (item['badge'] != '')
                                                  Container(
                                                    margin: const EdgeInsets.only(left: 6),
                                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFFFFF3E0),
                                                      borderRadius: BorderRadius.circular(3),
                                                    ),
                                                    child: Text(item['badge'],
                                                        style: const TextStyle(color: Colors.orange, fontSize: 7)),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
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
                                          const SizedBox(height: 4),
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}