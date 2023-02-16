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

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<UserData> data = [];

  @override
  void initState() {
    super.initState();
    _database.ref().child("users").child("user_data").once().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.snapshot.value as dynamic;
      values.forEach((key, value) {
        if (value['role'] == 'user') {
          UserData userData = UserData(
            email: value['email'],
            firstName: value['first_name'],
            lastName: value['last_name'],
            phone: value['phone'],
            role: value['role'],
          );
          setState(() {
            data.add(userData);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("ข้อมูลนักเรียน"),
      ),
      body: Container(
        decoration: BoxDecoration(shape: BoxShape.rectangle),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              height: 200,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index].email,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${data[index].firstName}  ${data[index].firstName}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    data[index].phone,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
            // ListTile(
            //   title: Text(
            //       "Name: ${data[index].firstName} ${data[index].lastName}"),
            //   subtitle: Text(
            //       "Email: ${data[index].email} \nPhone: ${data[index].phone}"),
            //   trailing: Text("Role: ${data[index].role}"),
            // );
          },
        ),
      ),
    );
  }
}

class UserData {
  String email;
  String firstName;
  String lastName;
  String phone;
  String role;

  UserData(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.role});
}
