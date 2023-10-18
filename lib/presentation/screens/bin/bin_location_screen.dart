import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

List<Map<String, dynamic>> data = [
  {
    'id': '0',
    'position': const LatLng(10.1617, 76.2154),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '1',
    'position': const LatLng(10.1615, 76.2162),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '2',
    'position': const LatLng(10.1657, 76.2135),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '3',
    'position': const LatLng(10.1673, 76.2122),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '4',
    'position': const LatLng(10.1711, 76.2102),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '5',
    'position': const LatLng(10.1785, 76.2109),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '6',
    'position': const LatLng(10.2139, 76.1981),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '7',
    'position': const LatLng(10.1505, 76.2182),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '8',
    'position': const LatLng(10.1485, 76.2249),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '9',
    'position': const LatLng(10.1503, 76.2315),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '10',
    'position': const LatLng(10.1412, 76.2038),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '11',
    'position': const LatLng(10.1391, 76.1943),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '12',
    'position': const LatLng(10.1395, 76.1792),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '13',
    'position': const LatLng(10.1768, 76.1653),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '14',
    'position': const LatLng(10.1660, 76.2023),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '15',
    'position': const LatLng(10.1897, 76.1882),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '16',
    'position': const LatLng(10.1747, 76.2325),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '17',
    'position': const LatLng(10.1766, 76.2424),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
  {
    'id': '18',
    'position': const LatLng(10.9478, 76.0292),
    'assetPath': 'asset/images/bin-image-medium.png'
  },
];

class BinLocation extends StatefulWidget {
  const BinLocation({super.key});

  @override
  State<BinLocation> createState() => BinLocationState();
}

class BinLocationState extends State<BinLocation> {
  @override
  void initState() {
    generateMarker();
    super.initState();
  }

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
            markerId: MarkerId(index.toString()),
            position: data[index]['position'],
            icon: isVisible
                ? marker[index.toString()]!.icon
                : BitmapDescriptor.defaultMarker,
            infoWindow: const InfoWindow(title: "bin"),
          );
        }).toSet(),
        onCameraMove: onCameraMove,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 100),
        child: FloatingActionButton.extended(
          label: Text("current location"),
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

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class BinLocation extends StatefulWidget {
//   const BinLocation({super.key});

//   @override
//   State<BinLocation> createState() => BinLocationState();
// }

// class BinLocationState extends State<BinLocation> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   // List<Marker> _markers = [
//   //   Marker(
//   //     markerId: MarkerId('_kGooglePlex'),
//   //     infoWindow: InfoWindow(title: 'Suhails House'),
//   //     icon: BitmapDescriptor.defaultMarker,
//   //     position: LatLng(9.93854004152453, 76.32178450376257),
//   //   )
//   // ];

//   loadData() {
//     getUserCurrentLocation().then((value) async {
//       print("my current location");
//       print(value.latitude.toString() + " " + value.longitude.toString());

//       // _markers.add(Marker(
//       //     markerId: MarkerId('2'),
//       //     position: LatLng(value.latitude, value.longitude),
//       //     infoWindow: InfoWindow(title: 'My current Location')));

//       CameraPosition cameraPosition = CameraPosition(
//         zoom: 14,
//         target: LatLng(value.latitude, value.longitude),
//       );

//       final GoogleMapController controller = await _controller.future;

//       controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//       setState(() {});
//     });
//   }

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(9.93854004152453, 76.32178450376257),
//     zoom: 14.4746,
//   );

//   // static const CameraPosition _kLake = CameraPosition(
//   //     bearing: 192.8334901395799,
//   //     target: LatLng(37.43296265331129, -122.08832357078792),
//   //     tilt: 59.440717697143555,
//   //     zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _kGooglePlex,
//         // markers: Set<Marker>.of(_markers),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(right: 100),
//         child: FloatingActionButton.extended(
//           label: Text("Current Location"),
//           onPressed: () async {
//             loadData();
//           },
//         ),
//       ),
//     );
//   }

//   // Future<void> _goToTheLake() async {
//   //   final GoogleMapController controller = await _controller.future;
//   //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   // }
// }

// Future<Position> getUserCurrentLocation() async {
//   await Geolocator.requestPermission()
//       .then((value) {})
//       .onError((error, stackTrace) {
//     print("error" + error.toString());
//   });

//   return await Geolocator.getCurrentPosition();
// }
