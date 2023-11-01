// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/screens/wastecollection/current_location.dart';
import 'package:waste_management/presentation/screens/wastecollection/pay_success_screen.dart';
import 'package:waste_management/presentation/screens/wastecollection/saved_location.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';

class LocationChoosingScreen extends StatelessWidget {
  String title;
  int index;
  LocationChoosingScreen({Key? key, required this.title, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff53B4A9),
                Color(0xffB1E5B4)
              ], // Adjust colors as needed
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0), // Adjust the padding as needed
          child: BackButtonCustomMade(), // Replace with your custom back button
        ),
        title: Text(
          title,
          style: primaryfont(color: Colors.black54),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff53B4A9),
              Color(0xffB1E5B4)
            ], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "When you request waste collection, our dedicated team ensures an efficient and eco-friendly process. Suppose you schedule a pickup and make a payment on Monday. In our system, your collection day is set for Thursday. Rest assured, our waste collection team will arrive promptly on Thursday to pick up your waste. We take pride in optimizing our operations to minimize the environmental impact while accommodating your scheduling preferences. By offering specific collection days based on your requests, we aim to make waste disposal a convenient and hassle-free experience for you and your community.",
                    textAlign: TextAlign.justify,
                    style: primaryfont(color: white, fontSize: 12),
                  )
                ],
              ),
              sizedBox50,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return CurrentLocation(
                                title: title,
                                index: index,
                                amount: "50",
                              );
                            },
                          ));
                        },
                        child: Container(
                          height: size.height * .16,
                          width: size.width * .35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffEDFBE2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Share \nLocation",
                                  style: primaryfont(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Image.asset(
                                    "asset/images/logos_google-maps.png",
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const SavedLocation();
                            },
                          ));
                        },
                        child: Container(
                          height: size.height * .16,
                          width: size.width * .35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffEDFBE2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Saved\nLocation",
                                  style: primaryfont(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset(
                                  "asset/images/app-location-logo.png",
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  sizedBox30,
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * .6,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(primaryColor)),
                        child: Text(
                          "₹ 50.00",
                          style: primaryfont(color: white, fontSize: 24),
                        ),
                      )),
                  sizedBox30,
                  // InkWell(
                  //   onLongPress: () {},
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) {
                  //         return const PaymentSuccessful();
                  //       },
                  //     ));
                  //   },
                  //   splashFactory: InkRipple.splashFactory,
                  //   splashColor: Colors.blueAccent,
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(50)),
                  //     child: Container(
                  //       height: 70,
                  //       width: 70,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(50),
                  //           gradient: const LinearGradient(
                  //               colors: [Color(0xffB1E5B4), Color(0xff48AFA8)],
                  //               begin: Alignment.topCenter,
                  //               end: Alignment.bottomCenter)),
                  //       child: Center(
                  //         child: Text(
                  //           "Pay",
                  //           style: primaryfont(
                  //               fontSize: 24,
                  //               color: white,
                  //               fontWeight: FontWeight.w500),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
