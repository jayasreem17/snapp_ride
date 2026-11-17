
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

  final Color green = Color(0xFF009640);
  final Color black = Color(0xFF202636);
  final Color borderColor = Color(0xFFE2E5EA);

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
      backgroundColor: Color(0xFFF7F8FA),
      appBar: appBarWidget(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text('Full Name'),
              SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                validator: validateName,
                decoration: inputDecoration('Enter your name'),
              ),
              SizedBox(height: 16),
              Text('Mobile Number'),
              SizedBox(height: 8),
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                validator: validateMobile,
                decoration: inputDecoration('Enter mobile number'),
              ),
              SizedBox(height: 16),
              Text('Emergency Contact'),
              SizedBox(height: 8),
              TextFormField(
                controller: emergencyController,
                keyboardType: TextInputType.phone,
                validator: validateMobile,
                decoration: inputDecoration('Enter emergency number'),
              ),
              SizedBox(height: 16),
              Text('Email Address(optional)'),
              SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                decoration: inputDecoration('Enter email address'),
              ),
              SizedBox(height: 16),
              Text(
                'Gender',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              genderWidget(),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: updateDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Update Details',
                    style: TextStyle(
                      fontSize: 15,
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
      title: Text('Edit Details'),
      backgroundColor: Colors.white,
      foregroundColor: black,
      elevation: 0,
    );
  }

  Widget genderWidget() {
    return Row(
      children: [
        genderChip('Male'),
        SizedBox(width: 8),
        genderChip('Female'),
        SizedBox(width: 8),
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
      selectedColor: Colors.green,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: gender == value
            ? Color.fromARGB(255, 241, 238, 238)
            : Color.fromARGB(255, 15, 15, 15),
        fontSize: 11,
      ),
      shape: StadiumBorder(
        side: BorderSide(
          color: Color.fromARGB(255, 76, 76, 76),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
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
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void updateDetails() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
