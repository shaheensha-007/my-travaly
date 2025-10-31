import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:metechology/Widgets/Navigationservice.dart';
import '../../views/Homepage/Homepage.dart';

class GoogleAuthController {
  Future<void> signInWithGoogle(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;

      if (user != null) {
        // ✅ Successful login — navigate to Home
        NavigationService.push(const HomeScreen());

        // Optional: print Firebase token for debugging
        final firebaseIdToken = await user.getIdToken();
        debugPrint("Firebase ID Token: $firebaseIdToken");
      } else {
        throw FirebaseAuthException(
          code: 'USER_NULL',
          message: 'Google sign-in failed: user is null.',
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Firebase Auth Error: ${e.message}')),
      );
      await googleSignIn.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
      await googleSignIn.signOut();
    }
  }
}
