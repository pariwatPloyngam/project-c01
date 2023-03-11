// // // ignore_for_file: unused_field, prefer_const_constructors

// // import 'dart:async';

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart';
// // import 'package:project_flutter/Screen/login_page.dart';

// // class UserHomePage extends StatefulWidget {
// //   final user;
// //   final String firstName;
// //   final String lastName;
// //   final String parentName;
// //   final String parentLastName;
// //   final String studenID;
// //   final String phoneNumber;
// //   final String tagID;

// //   UserHomePage({
// //     super.key,
// //     @required this.user,
// //     required this.firstName,
// //     required this.lastName,
// //     required this.parentName,
// //     required this.parentLastName,
// //     required this.studenID,
// //     required this.phoneNumber,
// //     required this.tagID,
// //   });

// //   @override
// //   State<UserHomePage> createState() => _UserHomePageState();
// // }

// // class _UserHomePageState extends State<UserHomePage> {
// //   // late GoogleMapController mapController;

// //   // final LatLng _center = const LatLng(14.56450857290138, 100.46722288783008);
// //   // final LatLng startPoint = LatLng(14.56450857290138, 100.46722288783008);
// //   // final LatLng endPoint = LatLng(14.569920279383535, 100.454671344333);
// //   // Set<Marker> markers = {};
// //   // void _onMapCreated(GoogleMapController controller) {
// //   //   mapController = controller;
// //   //   setState(() {
// //   //     markers.add(startMarker);
// //   //     markers.add(endMarker);
// //   //   });
// //   // }

// //   // Marker startMarker = Marker(
// //   //   markerId: MarkerId('startMarker'),
// //   //   position: LatLng(14.56450857290138, 100.46722288783008),
// //   //   icon: BitmapDescriptor.defaultMarker,
// //   //   infoWindow: InfoWindow(title: 'Start point'),
// //   // );

// //   // Marker endMarker = Marker(
// //   //   markerId: MarkerId('endMarker'),
// //   //   position: LatLng(14.569920279383535, 100.454671344333),
// //   //   icon: BitmapDescriptor.defaultMarker,
// //   //   infoWindow: InfoWindow(title: 'End point'),
// //   // );
// //   String api = 'AIzaSyDsHPy70G8-V1fkFJYQzzHFN_Zkg2YErs0';
// //   final Completer<GoogleMapController> _controller = Completer();
// //   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
// //   static const LatLng destinationLocation = LatLng(37.33429383, -122.06600055);

// //   List<LatLng> polylineCoordinates = [];
// //   LocationData? currentLocation;

// //   void getCurrentLocation() {
// //     Location location = Location();
// //     location.getLocation().then((location) {
// //       currentLocation = location;
// //     });
// //   }

// //   @override
// //   void initState() {
// //     getCurrentLocation();
// //     getPolyPoints();
// //     super.initState();
// //   }

// //   void getPolyPoints() async {
// //     PolylinePoints polylinePoints = PolylinePoints();
// //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //       api,
// //       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
// //       PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
// //     );
// //     if (result.points.isNotEmpty) {
// //       for (var point in result.points) {
// //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //       }
// //       setState(() {});
// //     }
// //   }

// //   // void _onMapCreated(GoogleMapController controller) {
// //   //   _controller.complete(controller);
// //   //   getPolyPoints();
// //   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     var width = MediaQuery.of(context).size.width;
// //     var heigth = MediaQuery.of(context).size.height;
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back_ios_rounded),
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //         ),
// //         title: const Text('Maps Sample App'),
// //         elevation: 2,
// //       ),
// //       body: currentLocation == null
// //           ? Center(
// //               child: Text('Loading'),
// //             )
// //           : GoogleMap(
// //               initialCameraPosition: CameraPosition(
// //                 target: LatLng(
// //                     currentLocation!.latitude!, currentLocation!.longitude!),
// //                 zoom: 13.5,
// //               ),
// //               polylines: {
// //                   Polyline(
// //                       visible: false,
// //                       polylineId: PolylineId('route'),
// //                       points: polylineCoordinates,
// //                       color: Colors.red,
// //                       width: 20)
// //                 },
// //               markers: {
// //                   Marker(
// //                       markerId: MarkerId('location'),
// //                       position: LatLng(currentLocation!.latitude!,
// //                           currentLocation!.longitude!)),
// //                   const Marker(
// //                       markerId: MarkerId('source'), position: sourceLocation),
// //                   const Marker(
// //                       markerId: MarkerId('destination'),
// //                       position: destinationLocation),
// //                 }),
// //     );

// //     // Scaffold(
// //     //   body: Center(
// //     //     child: Column(
// //     //       mainAxisAlignment: MainAxisAlignment.center,
// //     //       children: <Widget>[
// //     //         Text(
// //     //           'Hi !',
// //     //           style: TextStyle(fontSize: 50),
// //     //         ),
// //     //         Text('Welcome to User Page', style: TextStyle(fontSize: 30)),
// //     //         Text(widget.firstName + widget.lastName,
// //     //             style: TextStyle(fontSize: 20)),
// //     //         Text(widget.parentName + widget.parentLastName,
// //     //             style: TextStyle(fontSize: 20)),

// //     //         Text('Email: ${widget.user.email}'),
// //     //         // Text('Email: ${user.uid}'),
// //     //         ElevatedButton(
// //     //           onPressed: () => _signOut(context),
// //     //           child: Text('Sign out'),
// //     //         ),
// //     //       ],
// //     //     ),
// //     //   ),
// //     // );
// //   }

// //   void _signOut(BuildContext context) async {
// //     await FirebaseAuth.instance.signOut();
// //     // ignore: use_build_context_synchronously
// //     Navigator.pushReplacement(
// //         context, MaterialPageRoute(builder: (context) => const LoginPage()));
// //   }
// // }

// //////////////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class UserHomePage extends StatefulWidget {
//   final user;
//   final String firstName;
//   final String lastName;
//   final String parentName;
//   final String parentLastName;
//   final String studenID;
//   final String phoneNumber;
//   final String tagID;

//   UserHomePage({
//     super.key,
//     @required this.user,
//     required this.firstName,
//     required this.lastName,
//     required this.parentName,
//     required this.parentLastName,
//     required this.studenID,
//     required this.phoneNumber,
//     required this.tagID,
//   });
//   @override
//   _UserHomePageState createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();

//   String googleAPiKey = "AIzaSyDx9Dqbp5xmwXj_5wEFBH9xBoYpPIogyco";

//   Set<Marker> markers = {}; //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

//   LatLng startLocation = const LatLng(27.6683619, 85.3101895);
//   LatLng endLocation = const LatLng(27.6688312, 85.3077329);

//   @override
//   void initState() {
//     markers.add(Marker(
//       //add start location marker
//       markerId: MarkerId(startLocation.toString()),
//       position: startLocation, //position of marker
//       infoWindow: const InfoWindow(
//         //popup info
//         title: 'Starting Point ',
//         snippet: 'Start Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     markers.add(Marker(
//       //add distination location marker
//       markerId: MarkerId(endLocation.toString()),
//       position: endLocation, //position of marker
//       infoWindow: const InfoWindow(
//         //popup info
//         title: 'Destination Point ',
//         snippet: 'Destination Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     getDirections(); //fetch direction polylines from Google API

//     super.initState();
//   }

//   getDirections() async {
//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(startLocation.latitude, startLocation.longitude),
//       PointLatLng(endLocation.latitude, endLocation.longitude),
//       travelMode: TravelMode.driving,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = const PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.blue,
//       points: polylineCoordinates,
//       width: 10,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Route Driection in Google Map"),
//         backgroundColor: Colors.amber,
//       ),
//       body: GoogleMap(
//         zoomGesturesEnabled: true, //enable Zoom in, out on map
//         initialCameraPosition: CameraPosition(
//           target: startLocation, //initial position
//           zoom: 16.0, //initial zoom level
//         ),
//         markers: markers, //markers to show on map
//         polylines: Set<Polyline>.of(polylines.values), //polylines
//         mapType: MapType.normal, //map type
//         onMapCreated: (controller) {
//           //method called when map is created
//           setState(() {
//             mapController = controller;
//           });
//         },
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// // class UserHomePage extends StatefulWidget {
// //   final user;
// //   final String firstName;
// //   final String lastName;
// //   final String parentName;
// //   final String parentLastName;
// //   final String studenID;
// //   final String phoneNumber;
// //   final String tagID;

// //   UserHomePage({
// //     super.key,
// //     @required this.user,
// //     required this.firstName,
// //     required this.lastName,
// //     required this.parentName,
// //     required this.parentLastName,
// //     required this.studenID,
// //     required this.phoneNumber,
// //     required this.tagID,
// //   });
// //   @override
// //   _UserHomePageState createState() => _UserHomePageState();
// // }

// // class _UserHomePageState extends State<UserHomePage> {
// //   late GoogleMapController mapController;

// //   // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
// //   // double _destLatitude = 6.849660, _destLongitude = 3.648190;
// //   double _originLatitude = 26.48424, _originLongitude = 50.04551;
// //   double _destLatitude = 26.46423, _destLongitude = 50.06358;
// //   Map<MarkerId, Marker> markers = {};
// //   Map<PolylineId, Polyline> polylines = {};
// //   List<LatLng> polylineCoordinates = [];
// //   PolylinePoints polylinePoints = PolylinePoints();
// //   String googleAPiKey = "AIzaSyDx9Dqbp5xmwXj_5wEFBH9xBoYpPIogyco";

// //   @override
// //   void initState() {
// //     super.initState();

// //     /// origin marker
// //     _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
// //         BitmapDescriptor.defaultMarker);

// //     /// destination marker
// //     _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
// //         BitmapDescriptor.defaultMarkerWithHue(90));
// //     _getPolyline();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //           body: GoogleMap(
// //         initialCameraPosition: CameraPosition(
// //             target: LatLng(_originLatitude, _originLongitude), zoom: 15),
// //         myLocationEnabled: true,
// //         tiltGesturesEnabled: true,
// //         compassEnabled: true,
// //         scrollGesturesEnabled: true,
// //         zoomGesturesEnabled: true,
// //         onMapCreated: _onMapCreated,
// //         markers: Set<Marker>.of(markers.values),
// //         polylines: Set<Polyline>.of(polylines.values),
// //       )),
// //     );
// //   }

// //   void _onMapCreated(GoogleMapController controller) {
// //     mapController = controller;
// //   }

// //   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
// //     MarkerId markerId = MarkerId(id);
// //     Marker marker =
// //         Marker(markerId: markerId, icon: descriptor, position: position);
// //     markers[markerId] = marker;
// //   }

// //   _addPolyLine() {
// //     PolylineId id = PolylineId("poly");
// //     Polyline polyline = Polyline(
// //         polylineId: id, color: Colors.red, points: polylineCoordinates);
// //     polylines[id] = polyline;
// //     setState(() {});
// //   }

// //   _getPolyline() async {
// //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //         googleAPiKey,
// //         PointLatLng(_originLatitude, _originLongitude),
// //         PointLatLng(_destLatitude, _destLongitude),
// //         travelMode: TravelMode.driving,
// //         wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
// //     if (result.points.isNotEmpty) {
// //       result.points.forEach((PointLatLng point) {
// //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //       });
// //     }
// //     _addPolyLine();
// //   }
// // }

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Screen/user/status-bar_widget.dart';
import 'networking.dart';

class UserHomePage extends StatefulWidget {
  final user;
  final String firstName;
  final String lastName;
  final String parentName;
  final String parentLastName;
  final String studenID;
  final String phoneNumber;
  final String tagID;

  UserHomePage({
    super.key,
    @required this.user,
    required this.firstName,
    required this.lastName,
    required this.parentName,
    required this.parentLastName,
    required this.studenID,
    required this.phoneNumber,
    required this.tagID,
  });

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late GoogleMapController mapController;
  late StreamSubscription _locationSubscription;
  late LatLng myLo;
  LatLng start = const LatLng(0, 0);
  LatLng end = const LatLng(0, 0);
  bool toggle = false;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  bool isData = false;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  List<Marker> markers = <Marker>[];
  final List<LatLng> polyPoints = [];
  final Set<Polyline> polyLines = {};
  var data;
  late String currentDate;
  bool status = false;
  // String status = '';

  @override
  void initState() {
    super.initState();
    getDate();
    getStatus();
    addCustomIcon();
    updateMap();
  }

  @override
  void dispose() {
    super.dispose();
    _locationSubscription.cancel();
  }

  getDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-M-dd');

    setState(() {
      currentDate = formatter.format(now);
    });
    print(currentDate);
  }

  void getStatus() {
    databaseReference
        .child('access')
        .child('2023-2-21')
        .child(widget.user.uid)
        .onValue
        .listen((event) {
      Map<dynamic, dynamic> values = event.snapshot.value as Map;
      if (values['status'] != '') {
        setState(() {
          status = true;
          // status = values['status'];
        });
      }
      getStatus();
    });
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
                size: Size(0.9, 0.9), devicePixelRatio: 0.5),
            'assets/image/location-mini.png')
        .then((icon) {
      setState(() {
        customIcon = icon;
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
    getJsonData();
  }

  void updateMap() {
    _locationSubscription = FirebaseDatabase.instance
        .ref()
        .child("Location")
        .child('current')
        .onValue
        .listen((event) {
      Map<dynamic, dynamic> location = event.snapshot.value as Map;
      double lat = location["Lat"];
      double lng = location["Lng"];
      setState(() {
        myLo = LatLng(lat, lng);
        markers.add(Marker(
            markerId: const MarkerId("currentLocation"),
            position: myLo,
            icon: customIcon,
            flat: false));
      });
      mapController.animateCamera(CameraUpdate.newLatLng(myLo));
    });
  }

  setMarkers() {
    markers.add(
      Marker(
          markerId: const MarkerId('Home'),
          position: start,
          flat: false,
          infoWindow: const InfoWindow(title: 'Start')),
    );
    markers.add(
      Marker(
          markerId: const MarkerId('School'),
          position: end,
          flat: false,
          infoWindow: const InfoWindow(title: 'End')),
    );
    setState(() {});
  }

  setPolyLines() {
    Polyline polyline = Polyline(
        polylineId: const PolylineId('polyline'),
        color: Colors.blue,
        width: 10,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: polyPoints);
    polyLines.add(polyline);
    setState(() {});
  }

  void getJsonData() async {
    await FirebaseDatabase.instance
        .ref()
        .child('Location')
        .child('start')
        .child(widget.user.uid)
        .once()
        .then((snapshot) {
      Map<dynamic, dynamic> startValue = snapshot.snapshot.value as dynamic;
      double lat = startValue['Lat'];
      double lng = startValue['Lng'];
      setState(() {
        start = LatLng(lat, lng);
      });
    });
    await FirebaseDatabase.instance
        .ref()
        .child('Location')
        .child('end')
        .once()
        .then((snapshot) {
      Map<dynamic, dynamic> endValue = snapshot.snapshot.value as dynamic;
      double lat = endValue['Lat'];
      double lng = endValue['Lng'];
      setState(() {
        end = LatLng(lat, lng);
      });
    });
    setMarkers();

    NetworkHelper network = NetworkHelper(
        startLng: start.longitude,
        startLat: start.latitude,
        endLng: end.longitude,
        endLat: end.latitude);
    try {
      data = await network.getData();

      LineString ls =
          LineString(data['features'][0]['geometry']['coordinates']);
      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }
      if (polyPoints.length == ls.lineString.length) {
        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            rotateGesturesEnabled: true,
            initialCameraPosition: const CameraPosition(
              target: LatLng(0, 0),
              zoom: 15,
            ),
            mapType: MapType.normal,
            markers: Set<Marker>.of(markers),
            polylines: polyLines,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            decoration: const BoxDecoration(color: AppColor.main),
          ),
          StatusBar(
              user: widget.user,
              firstName: widget.firstName,
              lastName: widget.lastName),
          Positioned(
            right: 0,
            top: 450,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColor.main,
                    child: Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColor.main,
                    child: Icon(
                      Icons.location_history_rounded,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}
