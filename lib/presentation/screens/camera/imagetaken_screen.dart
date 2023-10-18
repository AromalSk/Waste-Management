import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/full_bin_images.dart';
import 'package:waste_management/presentation/bloc/full_bin_image/full_bin_image_bloc.dart';
import 'package:waste_management/presentation/screens/camera/map_location_choosing.dart';
import 'package:waste_management/presentation/screens/camera/request_list_screen.dart';
import 'package:waste_management/presentation/screens/camera/request_success_screen.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';

// ignore: must_be_immutable
class ImageTakenScreen extends StatelessWidget {
  String? location;
  ImageTakenScreen({super.key, this.location});

  // File? imageFile;
  UploadTask? uploadTask;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
                stops: [0.1, 0.9],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonCustomMade(),
                  ],
                ),
              ),
              sizedBox10,
              GestureDetector(onTap: () async {
                XFile? pic = await takeCamera();
                // setState(() {
                //   imageFile = File(pic!.path);
                // });
                context
                    .read<FullBinImageBloc>()
                    .add(FullBinImageEvent(imageFile: File(pic!.path)));
              }, child: BlocBuilder<FullBinImageBloc, FullBinImageState>(
                builder: (context, state) {
                  return SizedBox(
                    height: size.height * 0.4,
                    width: size.width * 0.8,
                    child: state.mainImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              state.mainImage!,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Card(
                            elevation: 10,
                            color: primaryColor,
                            child: Icon(
                              Icons.camera_enhance,
                              color: thirdColor,
                              size: 50,
                            ),
                          ),
                  );
                },
              )),
              sizedBox30,
              location == null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * .8,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return PictureLocation();
                            },
                          ));
                        },
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              "asset/images/logos_google-maps.png",
                              height: 30,
                            ),
                            Text(
                              "Choose Location ",
                              style: primaryfont(
                                  color: primaryColor, fontSize: 24),
                            ),
                          ],
                        ),
                      ))
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return PictureLocation();
                          },
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: forthColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(location ?? "",
                              style: primaryfont(color: white)),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
              backgroundColor: primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return RequestListScreen();
                  },
                ));
              },
              label: Text(
                "Request Queue",
                style: primaryfont(
                  color: white,
                ),
              )),
          BlocBuilder<FullBinImageBloc, FullBinImageState>(
            builder: (context, state) {
              return FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () async {
                  if (state.mainImage != null && location != null) {
                    String imageLink = await imageSendtoDB(state.mainImage!);
                    print("6");
                    detailsSentToFireStore(
                        imagePath: imageLink, location: location!);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("image sent successful")));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return RequestSuccessScreen();
                      },
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("There is no image or location")));
                  }
                },
                child: Icon(
                  Icons.send,
                  color: white,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  String generateUniqueId() {
    var now = DateTime.now();
    var random = Random().nextInt(10000);
    return '${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}_$random';
  }

  imageSendtoDB(File imageFile) async {
    print("1");
    String imageName = generateUniqueId();
    final path = 'bin_waste_images/$imageName.jpg';
    print("2");
    final ref = FirebaseStorage.instance.ref().child(path);
    print("3");
    uploadTask = ref.putFile(imageFile);
    print("4");
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Download : $urlDownload");
    return urlDownload;
  }

  Future<XFile?> takeCamera() async {
    ImagePicker picker = ImagePicker();
    XFile? photo = await picker.pickImage(source: ImageSource.camera);
    return photo;
  }

  void detailsSentToFireStore(
      {required String imagePath, required String location}) {
    final imagedetails = FirebaseFirestore.instance
        .collection('full-bin-images')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('image-list')
        .doc();
    final bin = FullBinImages(
        imagePath: imagePath,
        userLocation: location,
        status: false,
        dateTime: DateTime.now(),
        userId: imagedetails.id);
    imagedetails.set(bin.toMap());
    print("5");
  }
}
