import 'package:flutter/material.dart';
import '../viewmodel/refer_details_view_model.dart';

class ReferAndEarnViewScreen extends StatefulWidget {
  const ReferAndEarnViewScreen({super.key});

  @override
  State<ReferAndEarnViewScreen> createState() => _ReferAndEarnViewScreenState();
}

class _ReferAndEarnViewScreenState extends State<ReferAndEarnViewScreen> {
  final ReferAndEarnViewModel viewModel = ReferAndEarnViewModel();

  static const Color primary = Color(0xFF009640);
  static const Color titleColor = Color(0xFF111827);
  static const String font = 'Inter';

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Widget _step(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: font,
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _arrow() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 28),
      child: Icon(Icons.arrow_forward, size: 14, color: primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.black,
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).padding.top + 16, 20, 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => viewModel.goBack(context),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color(0xFF3A3A3A),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.chevron_left,
                                size: 24, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          viewModel.title,
                          style: const TextStyle(
                            fontFamily: font,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            viewModel.earnLabel,
                            style: const TextStyle(
                              fontFamily: font,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Referral Process',
                      style: TextStyle(
                        fontFamily: font,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _step(Icons.share_outlined, 'Share Referral\ncode'),
                        _arrow(),
                        _step(Icons.person_add_alt_outlined,
                            'Joined &\n3 rides Done'),
                        _arrow(),
                        _step(Icons.assignment_turned_in_outlined,
                            'Money Credit\nin Wallet'),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Referral Code : ',
                            style: TextStyle(
                              fontFamily: font,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          Text(
                            viewModel.referralCode,
                            style: const TextStyle(
                              fontFamily: font,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: viewModel.copyCode,
                            child: const Icon(Icons.copy_outlined,
                                size: 14, color: Colors.black),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.share_outlined,
                              size: 14, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1FAE5A),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.currency_rupee,
                                  size: 24, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${viewModel.referrals} Referrals',
                                    style: const TextStyle(
                                      fontFamily: font,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${viewModel.points} Points',
                                    style: const TextStyle(
                                      fontFamily: font,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Text(
                                    '10 Points = 5 rupees',
                                    style: TextStyle(
                                      fontFamily: font,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Total Earnings',
                                  style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  viewModel.totalEarnings,
                                  style: const TextStyle(
                                    fontFamily: font,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Added in Wallet',
                                  style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'History',
                        style: TextStyle(
                          fontFamily: font,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          children: [
                            for (int i = 0; i < viewModel.history.length; i++)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: i == viewModel.history.length - 1
                                          ? Colors.transparent
                                          : const Color(0xFFEDEFF0),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFF1F5F4),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                          Icons.person_add_alt_outlined,
                                          size: 16,
                                          color: titleColor),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            viewModel.history[i].title,
                                            style: const TextStyle(
                                              fontFamily: font,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: titleColor,
                                            ),
                                          ),
                                          Text(
                                            viewModel.history[i].date,
                                            style: const TextStyle(
                                              fontFamily: font,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF6B7280),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          viewModel.history[i].points,
                                          style: const TextStyle(
                                            fontFamily: font,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: primary,
                                          ),
                                        ),
                                        Text(
                                          viewModel.history[i].note,
                                          style: const TextStyle(
                                            fontFamily: font,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
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