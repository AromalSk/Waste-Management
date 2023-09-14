import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/camera/request_success_screen.dart';
import 'package:waste_management/presentation/home/widgets/backbutton.dart';

class ImageTakenScreen extends StatelessWidget {
  const ImageTakenScreen({super.key});

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
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonCustomMade(),
                  ],
                ),
              ),
              sizedBox50,
              Container(
                height: size.height * 0.3,
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              sizedBox30,
              SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                  width: MediaQuery.of(context).size.width * .8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return RequestSuccessScreen();
                        },
                      ));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(white)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "asset/images/logos_google-maps.png",
                          height: 30,
                        ),
                        Text(
                          "Choose Location",
                          style: primaryfont(color: primaryColor, fontSize: 24),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
