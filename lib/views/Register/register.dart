import 'package:flutter/material.dart';
import 'package:metechology/Contollers/Register%20controller/RegisterContoller.dart';

import '../../Widgets/CommonText.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = RegisterController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.emailController.dispose();
    controller.passwordController.dispose();
    super.dispose();
  }

  // 2. Email Validation Logic
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email address is required.';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsive padding
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: screenHeight * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
               TranslatorWidget(text:
                'Register & Join buddy!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 40),
              _buildTextField(
                controller: controller.emailController,
                hintText: 'Enter your e-mail',
                keyboardType: TextInputType.emailAddress,
                suffixIcon: Icons.mail_outline,
                // Pass the email validator function
                validators: _validateEmail,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: controller.passwordController,
                hintText: 'Enter password',
                obscureText: true,
                suffixIcon: Icons.lock_outline, // Lock icon
                // Pass the password validator function
                validators: _validatePassword,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.signin(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child:  TranslatorWidget(text:
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?)? validators,
    bool obscureText = false,
    required IconData suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: TextFormField(
        validator: validators,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          // Remove the default internal padding and border
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: InputBorder.none, // Removes the standard underline/box
          // Suffix icon as shown in the image
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 5.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.black, // Black background for the icon
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              suffixIcon,
              color: Colors.white, // White icon color
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
