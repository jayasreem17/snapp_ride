import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project11/features/yourprofiledetails/editdetails/viewmodel/edit_details_viewmodel.dart';

class EditDetailsViewScreen extends StatefulWidget {
  const EditDetailsViewScreen({super.key});

  @override
  State<EditDetailsViewScreen> createState() => _EditDetailsViewScreenState();
}

class _EditDetailsViewScreenState extends State<EditDetailsViewScreen> {
  final EditDetailsViewModel viewModel = EditDetailsViewModel();

  static const Color primary = Color(0xFF009640);
  static const Color titleColor = Color(0xFF111827);
  static const Color hintColor = Color(0xFF9CA3AF);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color errorColor = Color(0xFFDC2626);
  static const String font = 'Inter';

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint, String? error) {
    return InputDecoration(
      hintText: hint,
      errorText: error,
      counterText: '',
      hintStyle: const TextStyle(
        fontFamily: font,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: hintColor,
      ),
      errorStyle: const TextStyle(fontFamily: font, fontSize: 11, color: errorColor),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: primary, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
    );
  }

  Widget _label(String text, {String? optional}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontFamily: font,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
          children: [
            TextSpan(text: text),
            if (optional != null)
              TextSpan(
                text: ' $optional',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _genderChip(String text, GenderOption option) {
    final bool selected = viewModel.gender == option;
    return GestureDetector(
      onTap: () => viewModel.selectGender(option),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? primary : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: selected ? primary : borderColor),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: font,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: selected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
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
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF1F5F4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.chevron_left, size: 22, color: titleColor),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Profile Details',
                        style: TextStyle(
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
                    padding: const EdgeInsets.all(16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Full Name*'),
                        TextField(
                          controller: viewModel.fullNameController,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                          ],
                          decoration: _decoration('Enter Full Name', viewModel.nameError),
                          style: const TextStyle(fontFamily: font, fontSize: 13, color: titleColor),
                        ),
                        const SizedBox(height: 16),
                        _label('Emergency Mobile Number*'),
                        TextField(
                          controller: viewModel.emergencyController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: _decoration('Enter Emergency number', viewModel.phoneError),
                          style: const TextStyle(fontFamily: font, fontSize: 13, color: titleColor),
                        ),
                        const SizedBox(height: 16),
                        _label('Gender*'),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _genderChip('Male', GenderOption.male),
                            _genderChip('Female', GenderOption.female),
                            _genderChip('Prefer not to say', GenderOption.preferNotToSay),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _label('Email Address', optional: '(optional)'),
                        TextField(
                          controller: viewModel.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _decoration('Enter Address', viewModel.emailError),
                          style: const TextStyle(fontFamily: font, fontSize: 13, color: titleColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () => viewModel.updateDetails(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Update Details',
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