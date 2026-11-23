import 'package:flutter/material.dart';
import 'package:flutter_project11/features/yourprofiledetails/privacydetails/viewmodel/privacy_view_model.dart';


class PrivacyPolicyViewScreen extends StatefulWidget {
  const PrivacyPolicyViewScreen({super.key});

  @override
  State<PrivacyPolicyViewScreen> createState() =>
      _PrivacyPolicyViewScreenState();
}

class _PrivacyPolicyViewScreenState extends State<PrivacyPolicyViewScreen> {
  final PrivacyPolicyViewModel viewModel = PrivacyPolicyViewModel();

  static const Color titleColor = Color(0xFF111827);
  static const Color bodyColor = Color(0xFF111827);
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
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => viewModel.goBack(context),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1F5F4),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.chevron_left,
                                size: 22, color: titleColor),
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
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < viewModel.paragraphs.length;
                                  i++) ...[
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    viewModel.paragraphs[i],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontFamily: font,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.9,
                                      color: bodyColor,
                                    ),
                                  ),
                                ),
                                if (i != viewModel.paragraphs.length - 1)
                                  const SizedBox(height: 28),
                              ],
                            ],
                          ),
                        ),
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