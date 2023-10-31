import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:waste_management/domain/entities/weekly_collection.dart';

setCollectionDetailsToFirebase(int index, String location, String latitude,
    String longitude, String amount, String type) async {
  final userDoc = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  final gender = userDoc.data()?['gender'];

  final details = await FirebaseFirestore.instance
      .collection('weekly-collection-schedule')
      .doc('day$index')
      .collection('usersList')
      .doc();
  details.set(WeeklyCollection(
          location: location,
          latitude: latitude,
          longitude: longitude,
          amount: amount,
          userId: FirebaseAuth.instance.currentUser!.uid,
          dateTime: DateTime.now(),
          type: type,
          status: false,
          gender: gender)
      .toMap());
}