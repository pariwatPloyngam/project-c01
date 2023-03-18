// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Screen/login_page.dart';
import 'package:project_flutter/Screen/user/status-bar_widget.dart';
import 'package:project_flutter/Service/auth.dart';
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
    getDate();
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
        .child(currentDate)
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
        width: 5,
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
          // Positioned(
          //   right: 0,
          //   top: 450,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       // ignore: prefer_const_literals_to_create_immutables
          //       children: [
          //         const CircleAvatar(
          //           radius: 25,
          //           backgroundColor: AppColor.main,
          //           child: Icon(
          //             Icons.library_books,
          //             color: Colors.white,
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         const CircleAvatar(
          //           radius: 25,
          //           backgroundColor: AppColor.main,
          //           child: Icon(
          //             Icons.location_history_rounded,
          //             color: Colors.white,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}
