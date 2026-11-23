import 'package:flutter/material.dart';
import 'package:flutter_project11/features/completeridehistory/report/viewmodel/report_details_viewmodel.dart';

const Color _green = Color(0xFF009640);

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  ReportViewModel vm = ReportViewModel();

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
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
        title: const Text('Report', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black)),
      ),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, child) {
          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE3E3E3)),
                    boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
                  ),
                  child: Row(
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
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, -2))],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                          children: [
                            const Center(
                              child: Text('Reason for Reporting', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(height: 14),
                            ...List.generate(vm.reasons.length, (i) {
                              bool selected = vm.selected == i;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () => vm.selectReason(i),
                                  child: Container(
                                    height: 42,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: selected ? const Color(0xFFE9F7EE) : Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: selected ? _green : const Color(0xFFE3E3E3)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                          size: 18,
                                          color: selected ? _green : Colors.grey,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(vm.reasons[i], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFE3E3E3)),
                              ),
                              child: TextField(
                                controller: vm.complaintController,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 12),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write Your Complaint here',
                                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () => vm.submit(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _green,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Submit', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}