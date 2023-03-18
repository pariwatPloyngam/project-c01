import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_flutter/Component/color.dart';

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
    getUserData();
  }

  void getUserData() {
    _database.ref().child("users").child("user_data").once().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.snapshot.value as dynamic;
      values.forEach((key, value) {
        if (value['role'] == 'user') {
          UserData userData = UserData(
            email: value['email'],
            firstName: value['first_name'],
            lastName: value['last_name'],
            parentName: value['parent_name'],
            parentLastName: value['parent_lastname'],
            phone: value['phone'],
            stdclass: value['class'],
            room: value['room'],
            id: value['id'],
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
        backgroundColor: AppColor.main,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.mainText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "ข้อมูลนักเรียน",
          style: TextStyle(color: AppColor.mainText),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Container(
              // height: 120,
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
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 24, 0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/image/study1.jpg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data[index].firstName}  ${data[index].lastName}',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.mainText),
                            ),
                            Text(
                              'ชั้น ป. ${data[index].stdclass} ห้อง ${data[index].room}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.mainText),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'รหัส ${data[index].id}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.mainText),
                            ),
                            Row(
                              children: [
                                Text(
                                  'เบอร์ผู้ปกครอง ${data[index].phone}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.mainText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
  String parentName;
  String parentLastName;
  String stdclass;
  String room;
  String id;

  UserData(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.parentName,
      required this.parentLastName,
      required this.phone,
      required this.role,
      required this.stdclass,
      required this.room,
      required this.id});
}
