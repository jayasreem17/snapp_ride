
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project11/features/editdetailsbloc/viewmodel/edit_details_bloc_viewmodel.dart';

class EditDetailsView extends StatelessWidget {
  EditDetailsView({super.key});

  static const Color primary = Color(0xFF009640);
  static const Color titleColor = Color(0xFF111827);
  static const Color hintColor = Color(0xFF9CA3AF);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color errorColor = Color(0xFFDC2626);
  static const String font = 'Inter';

  InputDecoration decoration(String hint, String? error) {
    return InputDecoration(
      hintText: hint,
      errorText: error,
      counterText: '',
      hintStyle: TextStyle(
        fontFamily: font,
        fontSize: 13,
        color: hintColor,
      ),
      errorStyle: TextStyle(
        fontFamily: font,
        fontSize: 11,
        color: errorColor,
      ),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: errorColor),
      ),
    );
  }

  Widget label(String text, {String? optional}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
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
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget genderChip(
    BuildContext context,
    String text,
    GenderOption option,
    GenderOption selected,
  ) {
    bool isSelected = selected == option;

    return GestureDetector(
      onTap: () {
        context.read<EditDetailsBloc>().add(GenderChanged(option));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? primary : borderColor,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: font,
            fontSize: 12,
            color: isSelected ? Colors.white : Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditDetailsBloc(),
      child: Builder(
        builder: (context) {
          return BlocListener<EditDetailsBloc, EditDetailsState>(
            listenWhen: (previous, current) =>
                current.updated && !previous.updated,
            listener: (context, state) {
              EditDetailsBloc bloc = context.read<EditDetailsBloc>();

              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: primary,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 5),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Details Updated Successfully',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Full Name: ${bloc.fullNameController.text}'),
                      Text('Emergency Number: ${bloc.emergencyController.text}'),
                      Text('Gender: ${bloc.genderText}'),
                      Text(
                        'Email: ${bloc.emailController.text.isEmpty ? 'Not provided' : bloc.emailController.text}',
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: BlocBuilder<EditDetailsBloc, EditDetailsState>(
                  builder: (context, state) {
                    EditDetailsBloc bloc = context.read<EditDetailsBloc>();

                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).maybePop();
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F5F4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.chevron_left,
                                    size: 22,
                                    color: titleColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
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

                          SizedBox(height: 20),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFEBEDEF),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                label('Full Name*'),

                                TextField(
                                  controller: bloc.fullNameController,
                                  textCapitalization: TextCapitalization.words,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z ]'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    bloc.add(NameChanged(value));
                                  },
                                  decoration: decoration(
                                    'Enter Full Name',
                                    state.nameError,
                                  ),
                                  style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 13,
                                    color: titleColor,
                                  ),
                                ),

                                SizedBox(height: 16),

                                label('Emergency Mobile Number*'),

                                TextField(
                                  controller: bloc.emergencyController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (value) {
                                    bloc.add(PhoneChanged(value));
                                  },
                                  decoration: decoration(
                                    'Enter Emergency number',
                                    state.phoneError,
                                  ),
                                  style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 13,
                                    color: titleColor,
                                  ),
                                ),

                                SizedBox(height: 16),

                                label('Gender*'),

                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    genderChip(
                                      context,
                                      'Male',
                                      GenderOption.male,
                                      state.gender,
                                    ),
                                    genderChip(
                                      context,
                                      'Female',
                                      GenderOption.female,
                                      state.gender,
                                    ),
                                    genderChip(
                                      context,
                                      'Prefer not to say',
                                      GenderOption.preferNotToSay,
                                      state.gender,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),

                                label(
                                  'Email Address',
                                  optional: '(optional)',
                                ),

                                TextField(
                                  controller: bloc.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    bloc.add(EmailChanged(value));
                                  },
                                  decoration: decoration(
                                    'Enter Address',
                                    state.emailError,
                                  ),
                                  style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 13,
                                    color: titleColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                bloc.add(UpdateDetailsPressed());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Text(
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
            ),
          );
        },
      ),
    );
  }
}
