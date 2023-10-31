import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/collection_schedule.dart';
import 'package:waste_management/domain/repositories/collection_schedule.dart';
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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [BackButtonCustomMade()],
                  ),
                ),
                sizedBox10,
                FutureBuilder<List<CollectionSchedule>>(
                    future: getCollection(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error found");
                      } else if (!snapshot.hasData) {
                        return Text("There is no data");
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return LocationChoosingScreen(
                                      title: snapshot.data![index].type!,
                                      index: index,
                                    );
                                  },
                                ));
                              },
                              child: ListViewCustomMade(
                                heading: snapshot.data![index].days!,
                                subtitle: snapshot.data![index].type!,
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                sizedBox10
              ],
            ),
          )),
    );
  }
}
