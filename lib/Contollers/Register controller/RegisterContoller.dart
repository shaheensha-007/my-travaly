import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metechology/Widgets/Navigationservice.dart';
import '../../views/Homepage/Homepage.dart';

class RegisterController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // ✅ Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Sign-in function
  Future<void> signin(BuildContext context) async {
    try {
      // Firebase login
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      NavigationService.push(const HomeScreen());

    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else {
        message = e.message ?? 'Login failed. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
    }
  }

  // ✅ Dispose controllers to prevent memory leaks
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
