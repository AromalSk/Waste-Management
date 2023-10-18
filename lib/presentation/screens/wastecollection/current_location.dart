import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/screens/wastecollection/payment_screen.dart';
import 'package:waste_management/presentation/screens/wastecollection/saved_location.dart';

class CurrentLocation extends StatefulWidget {
  CurrentLocation({super.key, required this.title});
  String title;
  @override
  State<CurrentLocation> createState() => CurrentLocationState();
}

class CurrentLocationState extends State<CurrentLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  String? streetAddress = '';

  Position? userLocation;

  List<Marker> _markers = [
    Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'Suhails House'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(9.93854004152453, 76.32178450376257),
    )
  ];

  loadData() {
    getUserCurrentLocation().then((value) async {
      print("my current location");
      userLocation = value;
      print(value.latitude.toString() + " " + value.longitude.toString());

      _markers.add(Marker(
          markerId: MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: 'My current Location')));

      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  getAddress() async {
    if (userLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userLocation!.latitude, userLocation!.longitude);
      setState(() {
        streetAddress = placemarks.reversed.last.name.toString() +
            "\n" +
            placemarks.reversed.last.thoroughfare.toString() +
            "\n" +
            placemarks.reversed.last.subLocality.toString() +
            "\n" +
            placemarks.reversed.last.locality.toString() +
            "\n" +
            placemarks.reversed.last.administrativeArea.toString() +
            "\n" +
            placemarks.reversed.last.country.toString() +
            "\n" +
            placemarks.reversed.last.postalCode.toString();
        print(streetAddress.toString() + "hoi");
      });
    } else {
      return;
    }
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.93854004152453, 76.32178450376257),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Maps",
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          GestureDetector(
            onTap: () {
              getAddress();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: streetAddress == ""
                      ? Text(
                          "Get Address",
                          style: primaryfont(color: white),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          "${streetAddress.toString()}",
                          style: primaryfont(
                            color: white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            backgroundColor: primaryColor,
            label: Text(
              "Current Location",
              style: primaryfont(color: white),
            ),
            onPressed: () async {
              await loadData();
            },
          ),
          sizedBoxW30,
          CircleAvatar(
              radius: 25,
              backgroundColor: primaryColor,
              child: IconButton(
                  onPressed: () {
                    if (streetAddress != "") {
                      savedLocation.add(streetAddress.toString());

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return PaymentScreen(
                            streetAddress: streetAddress.toString(),
                            title: widget.title,
                          );
                        },
                      ));
                    }
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.send,
                      color: white,
                    ),
                  )))
        ],
      ),
    );
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
