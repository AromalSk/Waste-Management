import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';

class MessageBubbleUser extends StatelessWidget {
  final String message;

  const MessageBubbleUser({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: size.width * .6),
            width: null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.zero,
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Color(0xff44ADA8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: primaryfont(color: white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Align(
//       alignment: Alignment.centerRight,
//       child: ClipRRect(
        
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(100), // Adjust the radius as needed
//             bottomLeft: Radius.circular(100), // Adjust the radius as needed
//             bottomRight: Radius.circular(100),
//             topRight: Radius.circular(0) // Adjust the radius as needed
//             ),
//         child: Card(
//           color: Color(0xff44ADA8),
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(message),
//           ),
//         ),
//       ),
//     );