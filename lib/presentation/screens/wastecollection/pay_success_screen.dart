import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/screens/home/homepage.dart';

class PaymentSuccessful extends StatefulWidget {
  const PaymentSuccessful({super.key});

  @override
  State<PaymentSuccessful> createState() => _PaymentSuccessfulState();
}

class _PaymentSuccessfulState extends State<PaymentSuccessful> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('asset/lottie/animation_lmgfh1rw.json', height: 200),
            Text(
              "Payment Successful",
              style: primaryfont(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
