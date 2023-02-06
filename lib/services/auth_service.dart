import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hear_me/pages/fill_profile_page.dart';
import 'package:hear_me/pages/test_show_profile.dart';
import 'package:hear_me/services/check_if_email_exists.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthService {
  signUp({required String email, required String password}) async {
    // firebase auth
    firebase_auth.FirebaseAuth firebaseAuth =
        firebase_auth.FirebaseAuth.instance;
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  signInWithEmailAndPassword(
      {required String email, required String password}) async {
    firebase_auth.FirebaseAuth firebaseAuth =
        firebase_auth.FirebaseAuth.instance;

    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  signInWithGoogle(BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate
      checkIfEmailExists(FirebaseAuth.instance.currentUser!.email!)
          .then((exist) {
        if (exist) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ShowProfile()));
        } else {
          Navigator.of(context).pushNamed(FillProfilePage.id);
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      // rethrow;
    }
  }

  signOut() {
    GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}
