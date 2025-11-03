import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:metechology/Widgets/Navigationservice.dart';
import 'package:metechology/views/Homepage/Homepage.dart';
import '../../Contollers/Google_Contoller/Google_Auth.dart';
import '../../Widgets/CommonText.dart';
import '../Register/register.dart';

class GoogleAuthPage extends StatefulWidget {
  const GoogleAuthPage({super.key});

  @override
  State<GoogleAuthPage> createState() => _GoogleAuthPageState();
}

class _GoogleAuthPageState extends State<GoogleAuthPage> {
  final googleAuthController = GoogleAuthController();
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    const List<Color> gradientColors = [
       Color(0xFF17328D), // Your current blue as the starting color
      Color(0xFFF08080), // A lighter, soft coral/salmon color
      Color(0xFFE9967A) // A darker shade for the end of the gradient
    ];
    // final user = _authController.currentUser;
    //
    // if (user != null) {
    //   return const HomePage(); // Already logged in
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.hotel, size: 80, color: Colors.white),
                const SizedBox(height: 30),
                TranslatorWidget(
                    text:"Welcome to Hotel Finder",
                    // Change to:
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                   ),

                const SizedBox(height: 50),

                ElevatedButton.icon(
                  onPressed: (){
                  NavigationService.push(SignUpScreen());
                  },
                //  _handleSignIn,
                  icon: Icon(Icons.person,color: Colors.black,),
                  label:  TranslatorWidget(text: 'Sign in with personal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: (){
                    googleAuthController.signInWithGoogle(context);
                  },
                 // _handleSignIn,
                  icon: Image.asset('assets/google.png',
                      height: 24, width: 24),
                  label:  TranslatorWidget(text: 'Sign in with Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
