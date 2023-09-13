import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/home/widgets/backbutton.dart';
import 'package:waste_management/presentation/wastecollection/payment_screen.dart';
import 'package:waste_management/presentation/wastecollection/widgets/list_view.dart';

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
                              return PaymentScreen();
                            },
                          ));
                        },
                        child: ListViewCustomMade(
                          heading: "Everyday",
                          subtitle: "On demand collection",
                        ),
                      );
                    } else if (index == 1) {
                      return ListViewCustomMade(
                          heading: "Monday : Day 1",
                          subtitle: "General Waste Collection");
                    } else if (index == 2) {
                      return ListViewCustomMade(
                          heading: "Tuesday : Day 2",
                          subtitle: "Paper and Cardboard Recycling");
                    } else if (index == 3) {
                      return ListViewCustomMade(
                          heading: "Wednesday : Day 3",
                          subtitle: "Plastic Recycling");
                    } else if (index == 4) {
                      return ListViewCustomMade(
                          heading: "Thursday : Day 4",
                          subtitle: "Glass and Metal Recycling");
                    } else if (index == 5) {
                      return ListViewCustomMade(
                          heading: "Friday : Day 5",
                          subtitle: "E-waste and Hazardous waste");
                    } else if (index == 6) {
                      return ListViewCustomMade(
                          heading: "Saturday : Day 6",
                          subtitle: "Textiles and Clothing Collection");
                    } else if (index == 7) {
                      return ListViewCustomMade(
                          heading: "Sunday : Day 7",
                          subtitle:
                              "Medication Light bulbs and Special Collections");
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
