import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';

class ListViewCustomMade extends StatelessWidget {
  String heading;
  String subtitle;
  ListViewCustomMade(
      {super.key, required this.heading, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffE3F8D7),
        ),
        child: ListTile(
          title: Text(
            heading,
            style: primaryfont(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 16),
          ),
          enabled: true,
          textColor: Colors.black,
        ),
      ),
    );
  }
}
