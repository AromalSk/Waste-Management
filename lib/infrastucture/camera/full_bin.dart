// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:waste_management/domain/entities/full_bin_images.dart';
// Future<List<FullBinImages>> getQueryDataOfFullBin() async {
//   String currentUserID = FirebaseAuth.instance.currentUser!.uid;
//   List<FullBinImages> binsFull = [];

//   QuerySnapshot userAdminBinDetails = await FirebaseFirestore.instance
//       .collection('full-bin-images-admin')
//       .where('userId', isEqualTo: currentUserID)
//       .get();

//   binsFull = userAdminBinDetails.docs.map((data) {
//     Map<String, dynamic> mapContent = data.data();
//     return FullBinImages.fromMap(mapContent);
//   }).toList();

//   return binsFull;
// }