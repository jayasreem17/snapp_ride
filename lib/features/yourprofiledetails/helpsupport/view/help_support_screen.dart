import 'package:flutter/material.dart';
import '../viewmodel/help_support_view_model.dart';

class HelpSupportViewScreen extends StatefulWidget {
  const HelpSupportViewScreen({super.key});

  @override
  State<HelpSupportViewScreen> createState() => _HelpSupportViewScreenState();
}

class _HelpSupportViewScreenState extends State<HelpSupportViewScreen> {
  final HelpSupportViewModel viewModel = HelpSupportViewModel();

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
            return Padding(
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
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  for (final option in viewModel.options)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(option.icon,
                                size: 22, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            option.title,
                            style: const TextStyle(
                              fontFamily: font,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            option.value,
                            style: const TextStyle(
                              fontFamily: font,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
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