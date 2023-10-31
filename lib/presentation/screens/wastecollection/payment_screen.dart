// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/repositories/weekly_collection.dart';
import 'package:waste_management/presentation/screens/wastecollection/pay_success_screen.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';

class PaymentScreen extends StatelessWidget {
  String streetAddress;
  String title;
  int index;
  String latitude;
  String longitude;
  String amount;

  PaymentScreen(
      {Key? key,
      required this.streetAddress,
      required this.title,
      required this.index,
      required this.latitude,
      required this.longitude,
      required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    BackButtonCustomMade(),
                  ],
                ),
              ),
              sizedBox50,
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Confirm the details you have provided :",
                  style: primaryfont(color: white, fontSize: 20),
                ),
              ),
              sizedBox30,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff44ADA8),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: primaryfont(color: white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sizedBox10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff44ADA8),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          streetAddress,
                          style: primaryfont(color: white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sizedBox10,
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
              InkWell(
                // onLongPress: () {},
                onTap: () {
                  setCollectionDetailsToFirebase(
                      index, streetAddress, latitude, longitude, amount, title);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const PaymentSuccessful();
                    },
                  ));
                },
                splashFactory: InkRipple.splashFactory,
                splashColor: Colors.blueAccent,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                            colors: [Color(0xffB1E5B4), Color(0xff48AFA8)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                      child: Text(
                        "Pay",
                        style: primaryfont(
                            fontSize: 24,
                            color: white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


