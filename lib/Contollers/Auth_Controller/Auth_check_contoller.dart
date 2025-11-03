// auth_checker.dart (New File)
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // **Required** for Firebase Auth Stream
import 'package:metechology/views/Homepage/Homepage.dart';
import '../../views/Signin-up/Signin-up.dart'; // **You must create this file** for the logged-in user

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen to the authentication state
    // Replace 'FirebaseAuth.instance.authStateChanges()' with your actual stream
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // --- Connection State Check (Optional but good practice) ---
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You could show a small loading indicator or just let the
          // SplashScreen handle the wait time.
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // --- User Login Status Check ---
        final user = snapshot.data;

        if (user == null) {
          // 1. Not Logged In: Go to Login Page
          // The Signin-up.dart page from your import
          return const GoogleAuthPage(); // Or whatever your SignIn page widget is
        } else {
          // 2. Already Logged In: Go to Home Page
          return const HomeScreen();
        }
      },
    );
  }
}