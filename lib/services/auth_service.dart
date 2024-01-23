import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'notif_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function for Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser != null) {
        final GoogleSignInAuthentication gAuth = await gUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        final authResult = await _auth.signInWithCredential(credential);

        // Create a new user in Firestore if it doesn't exist
        await createUserInFirestore(authResult.user!.email!);

        return authResult;
      } else {
        throw Exception('Google Sign-In failed: User was null');
      }
    } catch (e) {
      print('Google Sign-In failed: $e');
      rethrow;
    }
  }



  // Function to create a new user in Firestore or update the existing user
  Future<void> createUserInFirestore(String email) async {

  }

  // Function to check if the user is logged in
  bool isUserLoggedIn() {
    return _auth.currentUser != null;
  }

  // Function to get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}