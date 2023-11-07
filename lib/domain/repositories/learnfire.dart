// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:waste_management/domain/entities/full_bin_images.dart';

// // Future<List<FullBinImages>> getStudy() async {
//   // List<FullBinImages> jose = [];
//    List<FullBinImages> das = [];
//   try {
//     // Retrieving Data as JSON and Converting to a Map<String, dynamic>:
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('full-bin-images')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('image-list')
//         .get();

  
//    das =  querySnapshot.docs.map((e) {
//       return FullBinImages(
//           imagePath: e['imagePath'],
//           userLocation: e['userLocation'],
//           status: e['status'],
//           dateTime: e['dateTime'],
//           imageListId: e['imageListId'],
//           gender: e['gender'],
//           userId: e['userId']);
//     }).toList();

//   } catch (e) {
//     print('Error: $e');
//   }
//   return das;
// }




//   final hello = querySnapshot.docs
//         .map((e) => e.data() as Map<String, dynamic>)
//         .toList();
// // Converting Map<String, dynamic> to FullBinImages Objects:
//     jose = hello.map((e) {
//       return FullBinImages(
//           imagePath: e['imagePath'],
//           userLocation: e['userLocation'],
//           status: e['status'],
//           dateTime: e['dateTime'],
//           imageListId: e['imageListId'],
//           gender: e['gender'],
//           userId: e['userId']);
//     }).toList();
