import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';

class WasteSegragationGuideline extends StatelessWidget {
  const WasteSegragationGuideline({super.key});

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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonCustomMade(),
                  ],
                ),
              ),
              Lottie.asset("asset/lottie/animation_lnidfakg.json"),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Proper Waste Segragation Guideline.",
                      style: primaryfont(fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
