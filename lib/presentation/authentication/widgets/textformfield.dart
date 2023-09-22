import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';

class TextFormFieldCustomMade extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController controller;
  final bool isEmailField;
  final bool password;
  final String? Function(String?)? customValidator;

  const TextFormFieldCustomMade({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.controller,
    this.isEmailField = false,
    required this.password,
    this.customValidator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        obscureText: password ? true : false,
        validator: (value) {
          if (customValidator != null) {
            final customError = customValidator!(value);
            if (customError != null) {
              return customError; // Return the custom validation error.
            }
          }
          return null;
        },
        controller: controller,
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
