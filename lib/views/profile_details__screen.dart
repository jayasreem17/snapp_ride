import 'package:flutter/material.dart';
import 'package:flutter_project11/viewmodels/profile_details_viewmodel.dart';
import 'package:flutter_project11/views/edit_details_screen.dart';


class ProfileDetailsViewScreen extends StatefulWidget {
  const ProfileDetailsViewScreen({super.key});

  @override
  State<ProfileDetailsViewScreen> createState() =>
      _ProfileDetailsViewScreenState();
}

class _ProfileDetailsViewScreenState extends State<ProfileDetailsViewScreen> {
  final ProfileDetailsViewModel viewModel = ProfileDetailsViewModel();

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
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFEBEDEF)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < viewModel.details.length; i++)
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: i == viewModel.details.length - 1
                                      ? Colors.transparent
                                      : const Color(0xFFF1F2F3),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  viewModel.details[i][0],
                                  style: const TextStyle(
                                    fontFamily: font,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: titleColor,
                                  ),
                                ),
                                Text(
                                  viewModel.details[i][1],
                                  style: const TextStyle(
                                    fontFamily: font,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const EditDetailsViewScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Edit Details',
                        style: TextStyle(
                          fontFamily: font,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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