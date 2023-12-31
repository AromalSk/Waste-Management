import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';

class BackButtonCustomMade extends StatelessWidget {
  const BackButtonCustomMade({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(thirdColor)),
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back_outlined,
        color: grey,
      ),
    );
  }
}
