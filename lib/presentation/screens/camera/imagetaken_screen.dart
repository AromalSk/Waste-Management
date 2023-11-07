import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/full_bin_id.dart';
import 'package:waste_management/domain/entities/full_bin_images.dart';
import 'package:waste_management/infrastucture/homepage/function.dart';
import 'package:waste_management/presentation/bloc/full_bin_image/full_bin_image_bloc.dart';
import 'package:waste_management/presentation/bloc/image_gender/image_gender_bloc.dart';
import 'package:waste_management/presentation/screens/camera/map_location_choosing.dart';
import 'package:waste_management/presentation/screens/camera/request_list_screen.dart';
import 'package:waste_management/presentation/screens/camera/request_success_screen.dart';
import 'package:waste_management/presentation/screens/home/homepage.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';

// ignore: must_be_immutable
class ImageTakenScreen extends StatelessWidget {
  String? location;

  String? gender;
  ImageTakenScreen({super.key, this.location});

  // File? imageFile;
  UploadTask? uploadTask;

  final user = FirebaseAuth.instance.currentUser!;

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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(thirdColor)),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: grey,
                      ),
                    ),
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
                        : const Card(
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
                              return const PictureLocation();
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
                            return const PictureLocation();
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
                    return const RequestListScreen();
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
              return BlocBuilder<ImageGenderBloc, ImageGenderState>(
                builder: (context, imagegender) {
                  gender = imagegender.genderUser;
                  return FloatingActionButton(
                    backgroundColor: primaryColor,
                    onPressed: () async {
                      if (state.mainImage != null && location != null) {
                        await getFirebaseUserData().then((data) {
                          if (data != null) {
                            context
                                .read<ImageGenderBloc>()
                                .add(ImageGenderEvent(gender: data['gender']));
                          }
                        });
                        String imageLink =
                            await imageSendtoDB(state.mainImage!);
                        print("6");
                        detailsSentToFireStore(
                            imagePath: imageLink, location: location!);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("image sent successful")));
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const RequestSuccessScreen();
                          },
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("There is no image or location")));
                      }
                    },
                    child: const Icon(
                      Icons.send,
                      color: white,
                    ),
                  );
                },
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
    FirebaseFirestore.instance
        .collection('full-bin-images')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(FullBinId(
                status: false,
                userId: FirebaseAuth.instance.currentUser!.uid,
                gender: gender!,
                userLocation: location)
            .toMap());

    final imagedetails = FirebaseFirestore.instance
        .collection('full-bin-images')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('image-list')
        .doc();
    final bin = FullBinImages(
        imageListId: imagedetails.id,
        gender: gender!,
        imagePath: imagePath,
        userLocation: location,
        status: false,
        dateTime: DateTime.now(),
        userId: FirebaseAuth.instance.currentUser!.uid);
    imagedetails.set(bin.toMap());

    final binAdmin =
        FirebaseFirestore.instance.collection('full-bin-images-admin').doc();
    binAdmin.set(FullBinImages(
            imagePath: imagePath,
            userLocation: location,
            status: false,
            dateTime: DateTime.now(),
            imageListId: imagedetails.id,
            gender: gender!,
            userId: FirebaseAuth.instance.currentUser!.uid)
        .toMap());
    print("5");
  }
}
