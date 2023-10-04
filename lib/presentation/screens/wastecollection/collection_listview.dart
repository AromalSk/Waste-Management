import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/screens/wastecollection/location_choosing_screen.dart';
import 'package:waste_management/presentation/widgets/list_view.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';

class CollectionListView extends StatelessWidget {
  const CollectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
                  stops: [0.1, 0.9],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [BackButtonCustomMade()],
                  ),
                ),
                sizedBox10,
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "On demand collection",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                          heading: "Everyday",
                          subtitle: "On demand collection",
                        ),
                      );
                    } else if (index == 1) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "General Waste Collection",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                            heading: "Monday : Day 1",
                            subtitle: "General Waste Collection"),
                      );
                    } else if (index == 2) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "Paper and Cardboard Recycling",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                            heading: "Tuesday : Day 2",
                            subtitle: "Paper and Cardboard Recycling"),
                      );
                    } else if (index == 3) {
                      return InkWell(
                         onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "Plastic Recycling",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                            heading: "Wednesday : Day 3",
                            subtitle: "Plastic Recycling"),
                      );
                    } else if (index == 4) {
                      return InkWell(
                         onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "Glass and Metal Recycling",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                            heading: "Thursday : Day 4",
                            subtitle: "Glass and Metal Recycling"),
                      );
                    } else if (index == 5) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "E-waste and Hazardous waste",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                            heading: "Friday : Day 5",
                            subtitle: "E-waste and Hazardous waste"),
                      );
                    } else if (index == 6) {
                      return InkWell(
                         onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "Textiles and Clothing Collection",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                            heading: "Saturday : Day 6",
                            subtitle: "Textiles and Clothing Collection"),
                      );
                    } else if (index == 7) {
                      return InkWell(
                         onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return LocationChoosingScreen(
                                title: "Medication Light bulbs and Special Collections",
                              );
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                            heading: "Sunday : Day 7",
                            subtitle:
                                "Medication Light bulbs and Special Collections"),
                      );
                    }
                  },
                ),
                sizedBox10
              ],
            ),
          )),
    );
  }
}
