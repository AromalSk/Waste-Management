import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/bloc/logout/logout_bloc.dart';
import 'package:waste_management/presentation/screens/authentication/login_signup_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final Size size = MediaQuery.of(context).size;

    // Future<UserDetails?> fetchData() async {
    //   try {
    //     final docUser =
    //         FirebaseFirestore.instance.collection('users').doc(user.uid);
    //     final snapshot = await docUser.get();

    //     if (snapshot.exists) {
    //       return UserDetails.fromJson(snapshot.data().toString());
    //     }
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // }

    return Scaffold(
        body: Container(
      // height: MediaQuery.of(context).size.height,
      width: size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
              stops: [0.1, 0.9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
            child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
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
                    var userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    var userName = userData['userName'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(thirdColor)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            color: grey,
                          ),
                        ),
                        sizedBox10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: primaryColor,
                              backgroundImage: userData['gender'] == "Female"
                                  ? const AssetImage(
                                      'asset/images/womenmain.png')
                                  : const AssetImage(
                                      'asset/images/man-main.png'),
                              child: Container(),
                            ),
                            sizedBoxW30,
                            Expanded(
                              child: Text(
                                userName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: primaryfont(color: white, fontSize: 26),
                              ),
                            )
                          ],
                        ),
                        sizedBox10,
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xff44ADA8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mobile Number",
                                  style:
                                      primaryfont(color: white, fontSize: 18),
                                ),
                                Text(userData["phonenumber"],
                                    style:
                                        primaryfont(color: white, fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                        sizedBox10,
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xff547981),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style:
                                      primaryfont(color: white, fontSize: 18),
                                ),
                                Text(userData['email'],
                                    style:
                                        primaryfont(color: white, fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                        sizedBox10,
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xff547981),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  style:
                                      primaryfont(color: white, fontSize: 18),
                                ),
                                Text(userData["address"],
                                    style:
                                        primaryfont(color: white, fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                        sizedBox10,
                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xff547981),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gender",
                                  style:
                                      primaryfont(color: white, fontSize: 18),
                                ),
                                Text(userData["gender"],
                                    style:
                                        primaryfont(color: white, fontSize: 18))
                              ],
                            ),
                          ),
                        ),
                        sizedBox10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xff547981),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date of Birth",
                                      style: primaryfont(
                                          color: white, fontSize: 18),
                                    ),
                                    Text(userData["birthdate"],
                                        style: primaryfont(
                                            color: white, fontSize: 18))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _showLogoutDialog(context);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    color: danger),
                                child: const Icon(
                                  Icons.logout,
                                  color: white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          sizedBox30
        ],
      ),
    ));
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Logout ?"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  context.read<LogoutBloc>().add(LogoutEvent());
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return const LoginSignup();
                    },
                  ));
                } catch (e) {
                  log(e.toString());
                  print(e.toString());
                }

                //  Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      });
}
