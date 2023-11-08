import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/full_bin_images.dart';
import 'package:waste_management/domain/repositories/full_bin_repo.dart';
import 'package:waste_management/presentation/screens/camera/imagetaken_screen.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE6F9DC),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                // Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                  builder: (context) {
                    return ImageTakenScreen();
                  },
                ), (route) => false);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) {
                //     return ImageTakenScreen();
                //   },
                // ));
              },
              child: Icon(Icons.arrow_back)),
          title: Text(
            "Request Queue",
            style: primaryfont(fontSize: 24, color: Colors.black54),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
                  stops: [0.1, 0.9],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('full-bin-images-admin')
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ); // While data is being fetched
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData) {
                // var userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                    FullBinImages currentItem = FullBinImages.fromMap(
                        data[index].data() as Map<String, dynamic>);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: null,
                        width: null,
                        decoration: BoxDecoration(
                            color: const Color(0xffEDFBE2),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                            leading: Container(
                                height: size.height * .1,
                                width: size.width * .17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: Image.network(
                                  currentItem.imagePath,
                                  fit: BoxFit.fill,
                                )),
                            title: Text(
                              textAlign: TextAlign.start,
                              currentItem.userLocation,
                              style: primaryfont(fontSize: 10),
                            ),
                            trailing: currentItem.status == true
                                ? const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Iconsax.cloud5,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                  )
                                : const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.highlight_remove_rounded,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  )),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
