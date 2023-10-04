import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
List<String> savedLocation = ["789 Coconut Avenue \nKochi, Kerala \n682001"];

class SavedLocation extends StatelessWidget {
  SavedLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffE6F9DC),
          centerTitle: true,
          title: Text(
            "Saved Location",
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
                  decoration: BoxDecoration(
                      color: Color(0xffEDFBE2),
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    title: Center(child: Text(savedLocation[index])),
                  ),
                ),
              );
            },
            itemCount: savedLocation.length,
          ),
        ));
  }
}

