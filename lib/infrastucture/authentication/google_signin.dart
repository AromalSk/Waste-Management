import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInFlutter extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    log("login 1");
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    log("login 2");
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    log("login 3");
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      log("Authentication successful");
    } catch (e) {
      log("Authentication error: $e");
    }
    log("login 4");
    notifyListeners();
  }

  
Future logout ()async{
  await googleSignIn.disconnect();
  FirebaseAuth.instance.signOut();
}
}

