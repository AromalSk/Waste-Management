import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

Future<void> logIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    log(e.toString());
  }
}
