import 'package:flutter/material.dart';
import 'package:flutter_project11/features/yourprofiledetails/helpcenter/viewmodel/help_center_view_model.dart';


class HelpCenterViewScreen extends StatefulWidget {
  const HelpCenterViewScreen({super.key});

  @override
  State<HelpCenterViewScreen> createState() => _HelpCenterViewScreenState();
}

class _HelpCenterViewScreenState extends State<HelpCenterViewScreen> {
  final HelpCenterViewModel viewModel = HelpCenterViewModel();

  static const Color primary = Color(0xFF009640);
  static const Color titleColor = Color(0xFF111827);
  static const String font = 'Inter';

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.goBack(context),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_left,
                              size: 24, color: titleColor),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        viewModel.title,
                        style: const TextStyle(
                          fontFamily: font,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontFamily: font,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (int i = 0; i < viewModel.faqs.length; i++)
                    GestureDetector(
                      onTap: () => viewModel.toggle(i),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    viewModel.faqs[i].question,
                                    style: TextStyle(
                                      fontFamily: font,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: viewModel.expandedIndex == i
                                          ? primary
                                          : titleColor,
                                    ),
                                  ),
                                ),
                                Icon(
                                  viewModel.expandedIndex == i
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 20,
                                  color: titleColor,
                                ),
                              ],
                            ),
                            if (viewModel.expandedIndex == i &&
                                viewModel.faqs[i].answer.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              Text(
                                viewModel.faqs[i].answer,
                                style: const TextStyle(
                                  fontFamily: font,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  height: 1.65,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}