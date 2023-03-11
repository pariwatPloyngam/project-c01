// // ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart';
// import 'package:intl/intl.dart';
// import 'package:project_flutter/Screen/user/networking.dart';

// class LineString {
//   LineString(this.lineString);
//   List<dynamic> lineString;
// }

// class UserHomePage extends StatefulWidget {
//   final user;
//   final String firstName;
//   final String lastName;

//   const UserHomePage(
//       {super.key,
//       required this.user,
//       required this.firstName,
//       required this.lastName});

//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }

// class _UserHomePageState extends State<UserHomePage> {
//   final databaseReference = FirebaseDatabase.instance.ref();

//   bool toggle = false;
//   bool show = false;
//   late GoogleMapController mapController;
//   final List<LatLng> polyPoints = [];
//   final Set<Polyline> polyLines = {};
//   List<Marker> markers = <Marker>[];
//   var data;
//   LatLng start = const LatLng(14.56462091892953, 100.4672221972025);
//   LatLng end = const LatLng(14.581522705381087, 100.47391422789181);
//   LatLng myLo = const LatLng(14.565488044212133, 100.46928454538268);

//   late String currentDate;
//   bool selectWidget = false;

//   getDate() {
//     var now = DateTime.now();
//     var formatter = DateFormat('yyyy-M-dd');
//     // String formattedDate = formatter.format(now);
//     setState(() {
//       currentDate = formatter.format(now);
//     });
//     print(currentDate);
//   }

//   @override
//   void initState() {
//     super.initState();
//     getJsonData();
//     getDate();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });

//     setMarkers();
//   }

//   setMarkers() {
//     markers.add(
//       Marker(
//           markerId: const MarkerId('Home'),
//           position: start,
//           infoWindow: const InfoWindow(title: 'Start')),
//     );
//     markers.add(
//       Marker(
//           markerId: const MarkerId('School'),
//           position: end,
//           infoWindow: const InfoWindow(title: 'End')),
//     );
//     markers.add(
//       Marker(
//         markerId: const MarkerId('MyLo'),
//         position: myLo,
//         infoWindow: const InfoWindow(title: 'My Location'),
//       ),
//     );
//     setState(() {});
//   }

//   setPolyLines() {
//     Polyline polyline = Polyline(
//         polylineId: const PolylineId('polyline'),
//         color: Colors.blue,
//         width: 10,
//         startCap: Cap.roundCap,
//         endCap: Cap.roundCap,
//         points: polyPoints);
//     polyLines.add(polyline);
//     setState(() {});
//   }

//   void getJsonData() async {
//     NetworkHelper network = NetworkHelper(
//         startLng: start.longitude,
//         startLat: start.latitude,
//         endLng: end.longitude,
//         endLat: end.latitude);

//     try {
//       data = await network.getData();

//       LineString ls =
//           LineString(data['features'][0]['geometry']['coordinates']);
//       for (int i = 0; i < ls.lineString.length; i++) {
//         polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
//       }
//       if (polyPoints.length == ls.lineString.length) {
//         setPolyLines();
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       return StreamBuilder(
//         stream: databaseReference.child('Location').child('current').onValue,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             // Get the data from the snapshot
//             var data = snapshot.data.snapshot.value;
//             List<dynamic> dataList = data.values.toList() ?? [];
//             if (dataList.isEmpty) {
//               // Show a loading indicator if the dataList is empty
//               return const Center(
//                 child: Text(
//                   'ยังไม่มีการบันทึกข้อมูลสำหรับวันนี้',
//                   style: TextStyle(fontSize: 22, color: Colors.grey),
//                 ),
//               );
//             } else {
//               // Build the UI with the data
//               return Scaffold(
//                 body: Stack(
//                   children: [
//                     GoogleMap(
//                       onMapCreated: _onMapCreated,
//                       initialCameraPosition: CameraPosition(
//                         target: myLo,
//                         zoom: 15,
//                       ),
//                       mapType: MapType.normal,
//                       markers: Set<Marker>.of(markers),
//                       polylines: polyLines,
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 80,
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                               begin: FractionalOffset.topCenter,
//                               end: FractionalOffset.bottomCenter,
//                               stops: const [0.0, 1.0],
//                               colors: [Colors.amber, Colors.amber.shade200]),
//                           borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(16),
//                               bottomRight: Radius.circular(16)),
//                           // ignore: prefer_const_literals_to_create_immutables
//                           boxShadow: [
//                             const BoxShadow(
//                                 color: Colors.transparent,
//                                 spreadRadius: 0,
//                                 offset: Offset(0, 0),
//                                 blurRadius: 8),
//                             const BoxShadow(
//                                 color: Color.fromARGB(255, 188, 188, 188),
//                                 spreadRadius: 1,
//                                 offset: Offset(1, 1),
//                                 blurRadius: 8)
//                           ]),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Text(
//                                               'ชื่อ ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.black87,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             Text(
//                                               '${widget.firstName}  ${widget.lastName}',
//                                               style: const TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.black87,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           // ignore: prefer_const_literals_to_create_immutables
//                                           children: [
//                                             const Text(
//                                               'สถานะ ',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.black87,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             const Text(
//                                               'อยู่บนรถโดยสาร',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   color: Colors.black87,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       width: 50,
//                                       child: Image.asset(
//                                           'assets/image/status-car.png'),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 0,
//                       top: 450,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           // ignore: prefer_const_literals_to_create_immutables
//                           children: [
//                             const CircleAvatar(
//                               radius: 25,
//                               backgroundColor: Colors.amber,
//                               child: Icon(
//                                 Icons.library_books,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             const CircleAvatar(
//                               radius: 25,
//                               backgroundColor: Colors.amber,
//                               child: Icon(
//                                 Icons.location_history_rounded,
//                                 color: Colors.white,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             }
//           } else {
//             return Container(
//                 child: Center(
//                     child: const CircularProgressIndicator(
//               color: Colors.amber,
//             )));
//           }
//         },
//       );
//     });
//   }
// }
