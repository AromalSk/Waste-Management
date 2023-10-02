import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';

class MessageBubbleAdmin extends StatelessWidget {
  final String message;

  const MessageBubbleAdmin({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: size.width * .6),
            width: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.zero,
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: primaryfont(
                    color: Color(0xff44ADA8), fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Align(
//       alignment: Alignment.centerLeft,
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(100), // Adjust the radius as needed
//             bottomLeft: Radius.circular(100), // Adjust the radius as needed
//             bottomRight: Radius.circular(100),
//             topRight: Radius.circular(0) // Adjust the radius as needed
//             ),
//         child: Card(
//           color: white,
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(message),
//           ),
//         ),
//       ),
//     );