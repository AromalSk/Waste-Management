import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/screens/bin/bin_location_screen.dart';
import 'package:waste_management/presentation/screens/camera/imagetaken_screen.dart';
import 'package:waste_management/presentation/screens/camera/request_success_screen.dart';

class PictureLocation extends StatefulWidget {
  const PictureLocation({super.key});

  @override
  State<PictureLocation> createState() => PictureLocationState();
}

class PictureLocationState extends State<PictureLocation> {
  @override
  void initState() {
    generateMarker();
    super.initState();
  }

  String? streetAddress = '';

  LatLng? userLocation;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Map<String, Marker> marker = {};
  List<bool> markerVisibility = [];

  generateMarker() async {
    for (int i = 0; i < data.length; i++) {
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), data[i]['assetPath']);

      markerVisibility.add(true);

      marker[i.toString()] = Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: data[i]['position'],
          icon: markerIcon,
          infoWindow: const InfoWindow(title: "bin"));
      setState(() {});
    }
  }

  onCameraMove(CameraPosition position) {
    // You can set a zoom threshold to control marker visibility
    const zoomThreshold = 10.0; // Adjust this threshold as needed

    // Check the current zoom level
    if (position.zoom < zoomThreshold) {
      // Remove all markers when zooming out
      setState(() {
        markerVisibility = [];
      });
    } else {
      // Show all markers when zooming in
      setState(() {
        markerVisibility = List.generate(data.length, (index) => true);
      });
    }
  }

  getAddress() async {
    if (userLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userLocation!.latitude, userLocation!.longitude);
      setState(() {
        streetAddress = "${placemarks.reversed.last.name}\n${placemarks.reversed.last.thoroughfare}\n${placemarks.reversed.last.subLocality}\n${placemarks.reversed.last.locality}\n${placemarks.reversed.last.administrativeArea}\n${placemarks.reversed.last.country}\n${placemarks.reversed.last.postalCode}";
        print(streetAddress.toString() + "hoi");
      });
    } else {
      return;
    }
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      print("my current location");
      print(value.latitude.toString() + " " + value.longitude.toString());

      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.93854004152453, 76.32178450376257),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markerVisibility.asMap().entries.map((entry) {
          final index = entry.key;
          final isVisible = entry.value;
          return Marker(
            onTap: () {
              try {
                userLocation = data[index]['position'];
                print(userLocation!.latitude);
                getAddress();
                print("ssssss");
                showModalBottomSheet(
                  backgroundColor: primaryColor,
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Bin Location",
                                style: primaryfont(color: white, fontSize: 24),
                              ),
                            ),
                            Text(
                              "${streetAddress.toString()}",
                              style: primaryfont(color: white),
                              textAlign: TextAlign.center,
                            ),
                            sizedBox30,
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return ImageTakenScreen(
                                        location: streetAddress,
                                      );
                                    },
                                  ));
                                },
                                child: Text("Send location"))
                          ],
                        ),
                      ),
                    );
                  },
                );
                // latAndLongPassing(context);
              } catch (e) {
                log(e.toString());
                print(e.toString());
              }
            },
            markerId: MarkerId(index.toString()),
            position: data[index]['position'],
            icon: isVisible
                ? marker[index.toString()]!.icon
                : BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: "${data[index]['position']}",
              onTap: () {},
            ),
          );
        }).toSet(),
        onCameraMove: onCameraMove,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            label: Text("current location"),
            onPressed: () async {
              loadData();
            },
          ),
        ],
      ),
    );
  }

  void latAndLongPassing(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return RequestSuccessScreen();
      },
    ));
  }
}

Future<Position> getUserCurrentLocation() async {
  await Geolocator.requestPermission()
      .then((value) {})
      .onError((error, stackTrace) {
    print("error" + error.toString());
  });

  return await Geolocator.getCurrentPosition();
}
