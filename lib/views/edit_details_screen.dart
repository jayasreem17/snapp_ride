
import 'package:flutter/material.dart';

class EditDetailsView extends StatefulWidget {
  EditDetailsView({super.key});

  @override
  State<EditDetailsView> createState() => _EditDetailsViewState();
}

class _EditDetailsViewState extends State<EditDetailsView> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emergencyController = TextEditingController();
  final emailController = TextEditingController();

  String gender = 'Male';

  final Color green = const Color(0xFF009640);
  final Color black = const Color(0xFF202636);
  final Color borderColor = const Color(0xFFE2E5EA);

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emergencyController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE9EBEF),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 15,
                      spreadRadius: 0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name*',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: nameController,
                      validator: validateName,
                      decoration: inputDecoration('Enter here'),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Mobile Number*',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      validator: validateMobile,
                      decoration: inputDecoration('Enter here'),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Emergency Mobile Number*',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: emergencyController,
                      keyboardType: TextInputType.phone,
                      validator: validateMobile,
                      decoration: inputDecoration('Enter here'),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Gender*',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    genderWidget(),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Text(
                          'Email Address',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: black,
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          '(optional)',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF858B96),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      decoration: inputDecoration('Enter here'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 33,
                child: ElevatedButton(
                  onPressed: updateDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Update Details',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBarWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: black,
      elevation: 0,
      toolbarHeight: 40,
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 23,
            width: 23,
            decoration: const BoxDecoration(
              color: Color(0xFFF0F5F2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 13,
              color: Color(0xFF202636),
            ),
          ),
        ),
      ),
      title: const Text(
        'Profile Details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF202636),
        ),
      ),
      titleSpacing: 4,
    );
  }

  Widget genderWidget() {
    return Row(
      children: [
        genderChip('Male'),
        const SizedBox(width: 8),
        genderChip('Female'),
        const SizedBox(width: 8),
        genderChip('Rather not say'),
      ],
    );
  }

  Widget genderChip(String value) {
    return ChoiceChip(
      label: Text(value),
      selected: gender == value,
      showCheckmark: false,
      onSelected: (selected) {
        selectGender(value);
      },
      selectedColor: green,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: gender == value
            ? Colors.white
            : const Color(0xFF697386),
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: gender == value
              ? green
              : borderColor,
          width: 0.8,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(
        horizontal: -2,
        vertical: -2,
      ),
    );
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())) {
      return 'Only letters are allowed';
    }

    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter mobile number';
    }

    if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value.trim())) {
      return 'Enter valid 10 digit mobile number';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(value.trim())) {
      return 'Enter valid email address';
    }

    return null;
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF8292AB),
        fontSize: 11,
        fontWeight: FontWeight.normal,
      ),
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 11,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: borderColor,
          width: 0.8,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: green,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 0.8,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
    );
  }

  void updateDetails() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Details updated successfully'),
        ),
      );

      debugPrint('Name: ${nameController.text}');
      debugPrint('Mobile: ${mobileController.text}');
      debugPrint('Emergency: ${emergencyController.text}');
      debugPrint('Email: ${emailController.text}');
      debugPrint('Gender: $gender');
    }
  }

  void selectGender(String value) {
    setState(() {
      gender = value;
    });
  }
}
