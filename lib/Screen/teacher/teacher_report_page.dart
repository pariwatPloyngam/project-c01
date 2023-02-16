// // ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';

// class ReportPage extends StatefulWidget {
//   const ReportPage({super.key});

//   @override
//   State<ReportPage> createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> {
//   Query dbref = FirebaseDatabase.instance.ref().child("access");
//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   // void getData() async {
//   //   database.ref().child('access').onValue.listen((snapshot) {
//   //     Map<dynamic, dynamic> values = snapshot.snapshot.value as dynamic;
//   //     values.forEach((key, value) {
//   //       setState(() {
//   //         db = FirebaseDatabase.instance
//   //             .ref()
//   //             .child("users")
//   //             .child('user_data')
//   //             .child(key);
//   //       });
//   //       print(key);
//   //     });
//   //   });
//   // }

//   // @override
//   // void initState() {

//   //   super.initState();
//   //   getData();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.amber.shade700,
//             size: 30,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: FirebaseAnimatedList(
//         query: dbref,
//         itemBuilder: (BuildContext context, DataSnapshot snapshot,
//             Animation<double> animation, int index) {
//           Map data = snapshot.value as Map;
//           data['key'] = snapshot.key;

//           if (data.isEmpty) {
//             return const CircularProgressIndicator();
//           } else {
//             return listItem(data: data);
//           }
//         },
//       ),
//     );
//   }
// }

// Widget listItem({required Map data}) {
//   return Container(
//     margin: const EdgeInsets.all(10),
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//         color: (data['status'] == '0')
//             ? Colors.white
//             : (data['status'] == '1')
//                 ? Colors.amber
//                 : Colors.green,
//         borderRadius: BorderRadius.circular(16),
//         // ignore: prefer_const_literals_to_create_immutables
//         boxShadow: [
//           const BoxShadow(
//               color: Colors.transparent,
//               spreadRadius: 0,
//               offset: Offset(0, 0),
//               blurRadius: 8),
//           const BoxShadow(
//               color: Color.fromARGB(255, 221, 221, 221),
//               spreadRadius: 1,
//               offset: Offset(1, 1),
//               blurRadius: 8)
//         ]),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'ID : ' + data['user_id'],
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           'Name : ' + data['first_name'] + data['last_name'],
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           'TAG ID : ' + data['student_id'],
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//         ),
//       ],
//     ),
//   );
// }

// // ignore_for_file: prefer_interpolation_to_compose_strings

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';

// class StudentPage extends StatefulWidget {
//   const StudentPage({super.key});

//   @override
//   State<StudentPage> createState() => _StudentPageState();
// }

// class _StudentPageState extends State<StudentPage> {
//   // Query dbref =
//   //     FirebaseDatabase.instance.ref().child("users").child('user_data');
//   final database = FirebaseDatabase.instance.ref();

//   Future getData() async {
//     await database
//         .child('users')
//         .child('user_data')
//         .orderByChild('role')
//         .equalTo('user')
//         .once()
//         .then((snapshot) {
//       Map<dynamic, dynamic> values = snapshot.snapshot.value as dynamic;
//       // if (values != null) {
//       // }
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios_rounded,
//               color: Colors.amber.shade700,
//               size: 30,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: FutureBuilder(
//           future: getData(),
//           builder: (BuildContext context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     title: Text(snapshot.data[index].email),
//                     subtitle: Text(snapshot.data[index].firstName +
//                         " " +
//                         snapshot.data[index].lastName),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }

//             return CircularProgressIndicator();
//           },
//         )
//         // FirebaseAnimatedList(
//         //   query: dbref,
//         //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
//         //       Animation<double> animation, int index) {
//         //     Map data = snapshot.value as Map;
//         //     data['key'] = snapshot.key;
//         //     if (data.isEmpty) {
//         //       return const CircularProgressIndicator();
//         //     }
//         //     return listItem(data: data);
//         //   },
//         // ),
//         );
//   }
// }

// Widget listItem({required Map data}) {
//   return Container(
//     margin: const EdgeInsets.all(10),
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         // ignore: prefer_const_literals_to_create_immutables
//         boxShadow: [
//           const BoxShadow(
//               color: Colors.transparent,
//               spreadRadius: 0,
//               offset: Offset(0, 0),
//               blurRadius: 8),
//           const BoxShadow(
//               color: Color.fromARGB(255, 221, 221, 221),
//               spreadRadius: 1,
//               offset: Offset(1, 1),
//               blurRadius: 8)
//         ]),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'ID : ' + data['id'],
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           'Name : ' + data['first_name'] + data['last_name'],
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//         ),
//         const SizedBox(
//           height: 5,
//         ),
//         Text(
//           'TAG ID : ' + data['tagid'],
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//         ),
//       ],
//     ),
//   );
// }

// // ignore_for_file: non_constant_identifier_names

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class ReportPage extends StatefulWidget {
//   const ReportPage({super.key});

//   @override
//   State<ReportPage> createState() => _ReportPageState();
// }

// class _ReportPageState extends State<ReportPage> {
//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   List<UserData> data = [];

//   @override
//   void initState() {
//     super.initState();
//     _database.ref().child("access").once().then((snapshot) {
//       Map<dynamic, dynamic> values = snapshot.snapshot.value as dynamic;
//       values.forEach((key, value) {
//         if (value != null) {
//           UserData userData = UserData(
//             status: value['status'],
//             firstName: value['first_name'],
//             lastName: value['last_name'],
//             student_id: value['student_id'],
//             user_id: value['user_id'],
//           );
//           setState(() {
//             data.add(userData);
//           });
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: Text("ข้อมูลนักเรียน"),
//       ),
//       body: Container(
//         decoration: BoxDecoration(shape: BoxShape.rectangle),
//         child: ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             return Container(
//               height: 200,
//               margin: const EdgeInsets.all(10),
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   // ignore: prefer_const_literals_to_create_immutables
//                   boxShadow: [
//                     const BoxShadow(
//                         color: Colors.transparent,
//                         spreadRadius: 0,
//                         offset: Offset(0, 0),
//                         blurRadius: 8),
//                     const BoxShadow(
//                         color: Color.fromARGB(255, 221, 221, 221),
//                         spreadRadius: 1,
//                         offset: Offset(1, 1),
//                         blurRadius: 8)
//                   ]),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data[index].status,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     '${data[index].firstName}  ${data[index].lastName}',
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     data[index].user_id,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                   Text(
//                     data[index].student_id,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w400),
//                   ),
//                 ],
//               ),
//             );
//             // ListTile(
//             //   title: Text(
//             //       "Name: ${data[index].firstName} ${data[index].lastName}"),
//             //   subtitle: Text(
//             //       "Email: ${data[index].email} \nPhone: ${data[index].phone}"),
//             //   trailing: Text("Role: ${data[index].role}"),
//             // );
//           },
//         ),
//       ),
//     );
//   }
// }

// class UserData {
//   String status;
//   String firstName;
//   String lastName;
//   String student_id;
//   String user_id;

//   UserData(
//       {required this.firstName,
//       required this.lastName,
//       required this.user_id,
//       required this.status,
//       required this.student_id});
// }

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ReportPage extends StatefulWidget {
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: databaseReference.child('access').onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // Get the data from the snapshot
            var data = snapshot.data.snapshot.value;
            List<dynamic> dataList = data.values.toList() ?? [];
            if (dataList.isEmpty) {
              // Show a loading indicator if the dataList is empty
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // Build the UI with the data
              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 14),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              const BoxShadow(
                                  color: Colors.transparent,
                                  spreadRadius: 0,
                                  offset: Offset(0, 0),
                                  blurRadius: 8),
                              const BoxShadow(
                                  color: Color.fromARGB(255, 221, 221, 221),
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                  blurRadius: 8)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 20,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: (dataList[index]['status'] == '0')
                                      ? Colors.white
                                      : (dataList[index]['status'] == '1')
                                          ? Colors.amber.shade300
                                          : Colors.green,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.amber.shade200),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, right: 50),
                              child: Column(
                                children: [
                                  Text(
                                    "${dataList[index]['first_name']} ${dataList[index]['last_name']}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    dataList[index]['status'] == '1'
                                        ? 'อยู่บนรถ'
                                        : 'ลงจากรถเเล้ว',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            // Show a loading indicator while the data is loading
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
