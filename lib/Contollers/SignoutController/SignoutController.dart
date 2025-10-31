import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:metechology/Widgets/Navigationservice.dart';
import '../../views/Signin-up/Signin-up.dart'; // <-- your login screen path

class SiginoutController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOutUser() async {
    try {
      // ✅ Sign out from Firebase
      await _auth.signOut();

      // ✅ Sign out from Google (if signed in with Google)
      await _googleSignIn.signOut();

      // ✅ Navigate back to Login screen (and clear navigation stack)
      NavigationService.push(const GoogleAuthPage());
    } catch (e) {
      print("Error during sign out: $e");
    }
  }
}
