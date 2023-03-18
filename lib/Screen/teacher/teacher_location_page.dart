import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Component/status_car_widget.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  // final user;
  // final String firstName;
  // final String lastName;
  // final String parentName;
  // final String parentLastName;
  // final String studenID;
  // final String phoneNumber;
  // final String tagID;

  // UserHomePage({
  //   super.key,
  //   @required this.user,
  //   required this.firstName,
  //   required this.lastName,
  //   required this.parentName,
  //   required this.parentLastName,
  //   required this.studenID,
  //   required this.phoneNumber,
  //   required this.tagID,
  // });

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GoogleMapController? mapController;
  late StreamSubscription _locationSubscription;
  late LatLng myLo;
  bool isLoading = true;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  List<Marker> markers = <Marker>[];
  final List<LatLng> polyPoints = [];
  final Set<Polyline> polyLines = {};

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    updateMap();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _locationSubscription.cancel();
  // }

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
    mapController = controller;
  }

  void updateMap() {
    Future.delayed(const Duration(seconds: 1), () {
      _locationSubscription = FirebaseDatabase.instance
          .ref()
          .child("Location")
          .child('current')
          .onValue
          .listen((snapshot) {
        Map<dynamic, dynamic> location = snapshot.snapshot.value as Map;
        double lat = location["Lat"];
        double lng = location["Lng"];
        setState(() {
          myLo = LatLng(lat, lng);
          isLoading = false;
          markers.add(Marker(
              markerId: const MarkerId("currentLocation"),
              position: myLo,
              icon: customIcon,
              flat: true));
        });
        mapController?.animateCamera(CameraUpdate.newLatLng(myLo));
      });
    });
  }

  // setMarkers() {
  //   markers.add(
  //     Marker(
  //         markerId: const MarkerId('Home'),
  //         position: start,
  //         flat: false,
  //         infoWindow: const InfoWindow(title: 'Start')),
  //   );
  //   markers.add(
  //     Marker(
  //         markerId: const MarkerId('School'),
  //         position: end,
  //         flat: false,
  //         infoWindow: const InfoWindow(title: 'End')),
  //   );
  //   setState(() {});
  // }

  // setPolyLines() {
  //   Polyline polyline = Polyline(
  //       polylineId: const PolylineId('polyline'),
  //       color: Colors.blue,
  //       width: 10,
  //       startCap: Cap.roundCap,
  //       endCap: Cap.roundCap,
  //       points: polyPoints);
  //   polyLines.add(polyline);
  //   setState(() {});
  // }

  // void getJsonData() async {
  //   // await FirebaseDatabase.instance
  //   //     .ref()
  //   //     .child('Location')
  //   //     .child('start')
  //   //     .child(widget.user.uid)
  //   //     .once()
  //   //     .then((snapshot) {
  //   //   Map<dynamic, dynamic> startValue = snapshot.snapshot.value as dynamic;
  //   //   double lat = startValue['Lat'];
  //   //   double lng = startValue['Lng'];
  //   //   setState(() {
  //   //     start = LatLng(lat, lng);
  //   //   });
  //   // });
  //   // await FirebaseDatabase.instance
  //   //     .ref()
  //   //     .child('Location')
  //   //     .child('end')
  //   //     .once()
  //   //     .then((snapshot) {
  //   //   Map<dynamic, dynamic> endValue = snapshot.snapshot.value as dynamic;
  //   //   double lat = endValue['Lat'];
  //   //   double lng = endValue['Lng'];
  //   //   setState(() {
  //   //     end = LatLng(lat, lng);
  //   //   });
  //   // });
  //   // setMarkers();

  //   NetworkHelper network = NetworkHelper(
  //       startLng: start.longitude,
  //       startLat: start.latitude,
  //       endLng: end.longitude,
  //       endLat: end.latitude);
  //   try {
  //     data = await network.getData();

  //     LineString ls =
  //         LineString(data['features'][0]['geometry']['coordinates']);
  //     for (int i = 0; i < ls.lineString.length; i++) {
  //       polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
  //     }
  //     if (polyPoints.length == ls.lineString.length) {
  //       setPolyLines();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.main,
        title: const Text(
          'ตำแหน่งรถ',
          style: TextStyle(color: AppColor.mainText, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.mainText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          isLoading == false
              ? GoogleMap(
                  onMapCreated: _onMapCreated,
                  rotateGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(myLo.latitude, myLo.longitude),
                    zoom: 18,
                  ),
                  mapType: MapType.normal,
                  markers: Set<Marker>.of(markers),
                  polylines: polyLines,
                  buildingsEnabled: true,
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: AppColor.mainIcon,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'กำลังค้นหาตำแหน่งรถ',
                        style: TextStyle(
                            fontSize: 22, color: Colors.grey.shade600),
                      )
                    ],
                  ),
                ),
          getBusStatus(),
        ],
      ),
    );
  }
}
