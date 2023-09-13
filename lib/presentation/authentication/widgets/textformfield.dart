import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';

class TextFormFieldCustomMade extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  const TextFormFieldCustomMade(
      {super.key, required this.prefixIcon, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        style: primaryfont(
          color: white,
        ),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: primaryfont(
              fontWeight: FontWeight.w500,
              color: white,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(100)),
            filled: true,
            fillColor: Colors.black.withOpacity(0.2),
            prefixIcon: Icon(
              prefixIcon,
              color: white,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 70,
            ),
            contentPadding: EdgeInsets.only()),
      ),
    );
  }
}
