import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/bin_location.dart';
import 'package:waste_management/infrastucture/authentication/google_signin.dart';
import 'package:waste_management/presentation/screens/bin/bin_location_screen.dart';
import 'package:waste_management/presentation/screens/camera/imagetaken_screen.dart';
import 'package:waste_management/presentation/screens/camera/request_success_screen.dart';

class PictureLocation extends StatefulWidget {
  const PictureLocation({super.key});

  @override
  State<PictureLocation> createState() => PictureLocationState();
}

class PictureLocationState extends State<PictureLocation> {
  List<BinLocationModel>? bins;

  @override
  void initState() {
    getDataFromFirebaseBinLocation().then((fetchedBins) {
      setState(() {
        bins = fetchedBins;
      });
      generateMarker(bins);
    });
    super.initState();
  }

  String? streetAddress = '';

  LatLng? userLocation;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Map<String, Marker> marker = {};
  List<bool> markerVisibility = [];

  generateMarker(List<BinLocationModel>? bins) async {
    if (bins != null) {
      for (int i = 0; i < bins.length; i++) {
        BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'asset/images/bin-image-medium.png');

        markerVisibility.add(true);

        marker[i.toString()] = Marker(
            markerId: MarkerId(
              i.toString(),
            ),
            position: LatLng(
                bins[i].latitude.toDouble(), bins[i].latitude.toDouble()),
            icon: markerIcon,
            infoWindow: const InfoWindow(title: "bin"));
        setState(() {});
      }
    }
  }

  onCameraMove(CameraPosition position, List<BinLocationModel>? bins) {
    if (bins != null) {
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
          markerVisibility = List.generate(bins.length, (index) => true);
        });
      }
    }
  }

  getAddress() async {
    if (userLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userLocation!.latitude, userLocation!.longitude);
      setState(() {
        streetAddress =
            "${placemarks.reversed.last.name}\n${placemarks.reversed.last.thoroughfare}\n${placemarks.reversed.last.subLocality}\n${placemarks.reversed.last.locality}\n${placemarks.reversed.last.administrativeArea}\n${placemarks.reversed.last.country}\n${placemarks.reversed.last.postalCode}";
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
      appBar: AppBar(
        title: Text(
          'Full Bin Image Location',
          style: primaryfont(color: primaryColor),
        ),
        centerTitle: true,
      ),
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
                userLocation = isVisible
                    ? LatLng(bins![index].latitude.toDouble(),
                        bins![index].longitude.toDouble())
                    : LatLng(0, 0);
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
                        decoration: const BoxDecoration(
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
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) {
                                      return ImageTakenScreen(
                                        location: streetAddress,
                                        latitude:
                                            userLocation!.latitude.toString(),
                                        longitude:
                                            userLocation!.longitude.toString(),
                                      );
                                    },
                                  ));
                                },
                                child: const Text("Send location"))
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
            position: isVisible
                ? LatLng(bins![index].latitude.toDouble(),
                    bins![index].longitude.toDouble())
                : LatLng(0, 0),
            icon: isVisible
                ? marker[index.toString()]!.icon
                : BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title:
                  "${isVisible ? LatLng(bins![index].latitude.toDouble(), bins![index].longitude.toDouble()) : LatLng(0, 0)}",
              onTap: () {},
            ),
          );
        }).toSet(),
        onCameraMove: (position) => onCameraMove(position, bins),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            backgroundColor: primaryColor,
            label: Text(
              "current location",
              style: primaryfont(color: white),
            ),
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
        return const RequestSuccessScreen();
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














// List<Map<String, dynamic>> data = [
//   {
//     'id': '0',
//     'position': const LatLng(10.1617, 76.2154),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '1',
//     'position': const LatLng(10.1615, 76.2162),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '2',
//     'position': const LatLng(10.1657, 76.2135),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '3',
//     'position': const LatLng(10.1673, 76.2122),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '4',
//     'position': const LatLng(10.1711, 76.2102),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '5',
//     'position': const LatLng(10.1785, 76.2109),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '6',
//     'position': const LatLng(10.2139, 76.1981),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '7',
//     'position': const LatLng(10.1505, 76.2182),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '8',
//     'position': const LatLng(10.1485, 76.2249),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '9',
//     'position': const LatLng(10.1503, 76.2315),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '10',
//     'position': const LatLng(10.1412, 76.2038),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '11',
//     'position': const LatLng(10.1391, 76.1943),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '12',
//     'position': const LatLng(10.1395, 76.1792),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '13',
//     'position': const LatLng(10.1768, 76.1653),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '14',
//     'position': const LatLng(10.1660, 76.2023),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '15',
//     'position': const LatLng(10.1897, 76.1882),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '16',
//     'position': const LatLng(10.1747, 76.2325),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '17',
//     'position': const LatLng(10.1766, 76.2424),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
//   {
//     'id': '18',
//     'position': const LatLng(10.9478, 76.0292),
//     'assetPath': 'asset/images/bin-image-medium.png'
//   },
// ];
