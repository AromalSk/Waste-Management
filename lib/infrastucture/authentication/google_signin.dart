import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waste_management/domain/entities/user.dart';
import 'package:waste_management/presentation/screens/authentication/details_screen.dart';
import 'package:waste_management/presentation/screens/home/homepage.dart';

final googleSignIn = GoogleSignIn();

GoogleSignInAccount? _user;

GoogleSignInAccount get user => _user!;

Future googleLogin(BuildContext context) async {
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

    final details = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final userDocument = await details.get();

    if (!userDocument.exists) {
      final user = UserDetails(
          email: FirebaseAuth.instance.currentUser!.email.toString());
      await details.set(user.toMap());

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const DetailScreen();
        },
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ));
    }
    log("Authentication successful");
  } catch (e) {
    log("Authentication error: $e");
  }
  log("login 4");
}

Future logout() async {
  try {
    FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
  } catch (e) {
    log(e.toString());
  }
}
