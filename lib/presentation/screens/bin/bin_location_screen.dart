import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/bin_location.dart';

Future<List<BinLocationModel>> getDataFromFirebaseBinLocation() async {
  print('hello');
  List<BinLocationModel> fetchedBins = [];
  final snapshot =
      await FirebaseFirestore.instance.collection('bin-location').get();
  if (snapshot.docs.isNotEmpty) {
    fetchedBins = snapshot.docs.map((data) {
      final mapcontent = data.data();
      return BinLocationModel.fromMap(mapcontent);
    }).toList();
  }

  return fetchedBins;
}

class BinLocation extends StatefulWidget {
  const BinLocation({super.key});

  @override
  State<BinLocation> createState() => BinLocationState();
}

class BinLocationState extends State<BinLocation> {
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

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Map<String, Marker> marker = {};
  List<bool> markerVisibility = [];

  generateMarker(List<BinLocationModel>? bins) async {
    if (bins != null) {
      print('hei');
      for (int i = 0; i < bins.length; i++) {
        print(bins[i].latitude);
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
        print(marker.length);
        setState(() {});
      }
    }
  }

  onCameraMove(CameraPosition position, List<BinLocationModel>? bins) {
    // You can set a zoom threshold to control marker visibility
    if (bins != null) {
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
          'Bin Location',
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
              _showGoogleDialog(context, bins![index].latitude.toDouble(),
                  bins![index].longitude.toDouble());
            },
            markerId: MarkerId(index.toString()),
            position: isVisible
                ? LatLng(bins![index].latitude.toDouble(),
                    bins![index].longitude.toDouble())
                : LatLng(0, 0),
            icon: isVisible
                ? marker[index.toString()]!.icon
                : BitmapDescriptor.defaultMarker,
            infoWindow: const InfoWindow(title: "bin"),
          );
        }).toSet(),
        onCameraMove: (position) => onCameraMove(position, bins),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 100),
        child: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          label: Text(
            "current location",
            style: primaryfont(color: white),
          ),
          onPressed: () async {
            loadData();
          },
        ),
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

void _showGoogleDialog(
    BuildContext context, double toLatitude, double toLongitude) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: Text(
            "Open Google Maps?",
            style: primaryfont(color: white),
          ),
          content: Text("You will be directed to this location in google maps",
              style: primaryfont(color: white)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: primaryfont(color: white)),
            ),
            TextButton(
              onPressed: () async {
                print('hello');
                try {
                  if (await canLaunchUrl(Uri.parse(
                      'https://www.google.com/maps/dir/?api=1&destination=$toLatitude,$toLongitude'))) {
                    await launchUrl(Uri.parse(
                        'https://www.google.com/maps/dir/?api=1&destination=$toLatitude,$toLongitude'));
                  } else {
                    throw 'Could not launch';
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text("OK", style: primaryfont(color: white)),
            ),
          ],
        );
      });
}
