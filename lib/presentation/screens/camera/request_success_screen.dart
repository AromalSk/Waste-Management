import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/screens/camera/request_list_screen.dart';

class RequestSuccessScreen extends StatefulWidget {
  const RequestSuccessScreen({super.key});

  @override
  State<RequestSuccessScreen> createState() => _RequestSuccessScreenState();
}

class _RequestSuccessScreenState extends State<RequestSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RequestListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('asset/lottie/camera_req.json'),
            Text(
              "Request Successful",
              style: primaryfont(fontSize: 24, color: white),
            ),
            Text(
              "Thank you for contributing\nto our mission of creating\na better world.",
              style: primaryfont(color: white),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
