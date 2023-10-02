import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/screens/camera/imagetaken_screen.dart';
import 'package:waste_management/presentation/screens/chat/chat_support.dart';
import 'package:waste_management/presentation/screens/home/profile.dart';
import 'package:waste_management/presentation/screens/wastecollection/collection_listview.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(color: Color(0xffEBEBEB)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const Profile();
                            },
                          ));
                        },
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: primaryColor,
                          child: Image.asset(
                            'asset/images/women.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(user.email!),
                  Text(user.displayName ?? "dhkfjshjkl"),
                  const SizedBox(
                    height: 80,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const CollectionListView();
                        },
                      ));
                    },
                    child: Container(
                      height: size.height * .15,
                      width: size.width * .9,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff44ADA8), Color(0xffB3E6B5)],
                              stops: [0.1, 0.9],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'asset/images/collection-weekly.png',
                            fit: BoxFit.cover,
                            width: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBox10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showCameraAlertDialog(context);
                          },
                          child: Container(
                            height: size.height * .19,
                            width: size.width * .43,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff44ADA8),
                                      Color(0xffB3E6B5)
                                    ],
                                    stops: [
                                      0.1,
                                      0.9
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/camera-logo.png',
                                  fit: BoxFit.cover,
                                  width: 35,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * .19,
                          width: size.width * .43,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color(0xff44ADA8),
                                    Color(0xffB3E6B5)
                                  ],
                                  stops: [
                                    0.1,
                                    0.9
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'asset/images/bin.png',
                                fit: BoxFit.cover,
                                width: 35,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBox10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ChatSupport();
                              },
                            ));
                          },
                          child: Container(
                            height: size.height * .19,
                            width: size.width * .43,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff44ADA8),
                                      Color(0xffB3E6B5)
                                    ],
                                    stops: [
                                      0.1,
                                      0.9
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    bottomRight: Radius.circular(6),
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(6))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/chat.png',
                                  fit: BoxFit.cover,
                                  width: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            log("hello");
                           
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) {
                            //     return const WasteSegragationGuideline();
                            //   },
                            // ));
                          },
                          child: Container(
                            height: size.height * .19,
                            width: size.width * .43,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xff44ADA8),
                                      Color(0xffB3E6B5)
                                    ],
                                    stops: [
                                      0.1,
                                      0.9
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(60),
                                    bottomLeft: Radius.circular(6),
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(15))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'asset/images/guideline.png',
                                  fit: BoxFit.cover,
                                  width: 35,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCameraAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Take a Photo"),
            content:
                const Text("Do you want to use the camera to take a photo?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the AlertDialog
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  // TODO: Implement camera functionality here
                  // You can add camera code or navigate to a camera screen
                  // For example, Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
                  await takeCamera();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return const ImageTakenScreen();
                    },
                  ));
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  Future<void> takeCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  }
}
