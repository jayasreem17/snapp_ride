
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../viewmodels/login_view_model.dart';

class LoginViewScreen extends StatelessWidget {
  LoginViewScreen({super.key});

  final Color primaryColor = Color(0xFF009640);
  final Color orangeColor = Color(0xFFFF9900);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Color(0xFFEDF3FC),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 440,
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical,
                  ),
                  child: IntrinsicHeight(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [

                          SizedBox(height: 16),

                          // Snapp Logo
                          SizedBox(
                            height: 100,
                            child: SvgPicture.asset(
                              'assets/images/Frame 1984082981.svg',
                              width: 190,
                              fit: BoxFit.contain,
                            ),
                          ),

                          SizedBox(height: 45),

                          // Welcome Text
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            'Login and continue your journey',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey,
                            ),
                          ),

                          SizedBox(height: 40),

                          // Email and Password Fields
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [

                                // Email Field
                                TextField(
                                  controller: viewModel.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: viewModel.onEmailChanged,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email Address',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.blueGrey,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 19,
                                      horizontal: 15,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: viewModel.emailError != null
                                            ? Colors.red
                                            : Color(0xFFDDE1E7),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                if (viewModel.emailError != null)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5, top: 7),
                                      child: Text(
                                        viewModel.emailError!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),

                                SizedBox(height: 20),

                                // Password Field
                                TextField(
                                  controller: viewModel.passwordController,
                                  obscureText: !viewModel.isPasswordVisible,
                                  onChanged: viewModel.onPasswordChanged,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.blueGrey,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed:
                                          viewModel.togglePasswordVisibility,
                                      icon: Icon(
                                        viewModel.isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 19,
                                      horizontal: 15,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: viewModel.passwordError != null
                                            ? Colors.red
                                            : Color(0xFFDDE1E7),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                if (viewModel.passwordError != null)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5, top: 7),
                                      child: Text(
                                        viewModel.passwordError!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),

                                SizedBox(height: 35),

                                // Login Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 53,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      viewModel.login(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 65),

                          // Terms and Privacy Policy
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  color: Color(0xFFA0A9B8),
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'By continuing, you agree to our ',
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 25),

                          // Contact Support
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(text: 'Need help? '),
                                TextSpan(
                                  text: 'Contact Support',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          // Charminar Image
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: SvgPicture.asset(
                                'assets/images/snapp_bottom.svg',
                                fit: BoxFit.contain,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
