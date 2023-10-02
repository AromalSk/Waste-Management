import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';

class RequestListScreen extends StatelessWidget {
  const RequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffE6F9DC),
          centerTitle: true,
          title: Text(
            "Request Queue",
            style: primaryfont(fontSize: 24, color: Colors.black54),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
                  stops: [0.1, 0.9],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: null,
                  width: null,
                  decoration: BoxDecoration(
                      color: Color(0xffEDFBE2),
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: Container(
                      height: size.height * .1,
                      width: size.width * .17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                    ),
                    title: Center(
                        child: Text(
                            "789 Coconut Avenue \nKochi, Kerala \n682001")),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.highlight_remove_rounded,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: 1,
          ),
        ));
  }
}
