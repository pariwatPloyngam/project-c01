import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Component/color.dart';

class getBusStatus extends StatefulWidget {
  const getBusStatus({
    super.key,
  });

  @override
  State<getBusStatus> createState() => _getBusStatusState();
}

class _getBusStatusState extends State<getBusStatus> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<DriverData> data = [];

  void getUserData() {
    _database.ref().child("users").child("user_data").once().then((snapshot) {
      Map<dynamic, dynamic> values = snapshot.snapshot.value as dynamic;
      values.forEach((key, value) {
        if (value['role'] == 'driver') {
          DriverData userData = DriverData(
            firstName: value['first_name'],
            lastName: value['last_name'],
            car_id: value['car_id'],
            phone: value['phone'],
          );
          setState(() {
            data.add(userData);
          });
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
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
                  color: Color.fromARGB(255, 173, 173, 173),
                  spreadRadius: 1,
                  offset: Offset(1, 1),
                  blurRadius: 8)
            ]),
        child: data.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bus_alert_sharp,
                    color: Colors.grey,
                    size: 40,
                  ),
                  const Center(
                    child: Text('ยังไท่ได้เพิ่มข้อมูลคนขับรถ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                  ),
                ],
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: prefer_const_constructors
                          Text(
                            'ชื่อคนขับรถ ${data[index].firstName}  ${data[index].lastName}',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColor.mainText),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Text(
                                        'ทะเบียนรถ : ${data[index].car_id}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColor.mainText),
                                      ),
                                      Text(
                                        'เบอร์โทร : ${data[index].phone}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColor.mainText),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
      ),
    );
  }
}

class DriverData {
  String firstName;
  String lastName;
  String phone;
  String car_id;

  DriverData({
    required this.firstName,
    required this.lastName,
    required this.car_id,
    required this.phone,
  });
}
