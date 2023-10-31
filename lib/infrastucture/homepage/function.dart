

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>?> getFirebaseUserData() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  } else {
    print('User not logged in');
    return null;
  }
}