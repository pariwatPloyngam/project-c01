import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Screen/user/user_home_page.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({
    super.key,
    required this.user,
    required this.lastName,
    required this.firstName,
    // required this.widget,
  });

  final String lastName;
  final String firstName;
  // final UserHomePage widget;
  final user;

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  bool isData = false;
  late String currentDate;
  getDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-M-dd');
    // String formattedDate = formatter.format(now);
    setState(() {
      currentDate = formatter.format(now);
    });
    print(currentDate);
  }

  @override
  void initState() {
    getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return StreamBuilder(
        stream: databaseReference
            .child('access')
            .child(currentDate)
            .child(widget.user.uid)
            .onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data?.snapshot?.value;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
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
                        color: Color.fromARGB(255, 179, 179, 179),
                        spreadRadius: 1,
                        offset: Offset(2, 2),
                        blurRadius: 8)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'การติดดตามสถานะการโดยสาร',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.mainText,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'ชื่อ ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.subext,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${widget.firstName} ${widget.lastName}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColor.subext,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    'สถานะ ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.subext,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    (data == null || data['status'] == '0')
                                        ? 'ยังไม่ได้ขึ้นรถ'
                                        : (data != null &&
                                                data['status'] == '1')
                                            ? 'อยู่บนรถ'
                                            : 'ลงจากรถเเล้ว',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColor.subext,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            width: 50,
                            child: (data == null || data['status'] == '0')
                                ? Image.asset('assets/image/status-home.png')
                                : (data != null && data['status'] == '1')
                                    ? Image.asset('assets/image/status-car.png')
                                    : Image.asset(
                                        'assets/image/status-school.png'),
                          )
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
    });
  }
}
