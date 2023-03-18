// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/Component/color.dart';

import 'package:project_flutter/Screen/login_page.dart';
import 'package:project_flutter/Service/auth.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({
    Key? key,
    required this.firstName,
    required this.lastName,
    this.user,
    required this.phoneNumber,
  }) : super(key: key);
  final user;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final _editkey = GlobalKey<FormState>();
  String? phoneEdit;

  late String currentDate;

  String? string;

  getDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-M-dd');
    // String formattedDate = formatter.format(now);
    setState(() {
      currentDate = formatter.format(now);
    });
    print(currentDate);
  }

  void getStdNum() {
    databaseReference
        .child('access')
        .child(currentDate)
        .orderByChild('status')
        .equalTo("1")
        .onValue
        .listen((values) {
      Map<dynamic, dynamic> data;
      if (values.snapshot.value != null) {
        data = values.snapshot.value as Map;

        setState(() {
          string = data.length.toString();
        });
        print(string);
        // Process the data here
      } else {
        setState(() {
          string = '0';
        });
        // Handle the case when there are no records
        print("$string");
      }
    });
  }

  @override
  void initState() {
    getDate();
    getStdNum();
    super.initState();
  }

  @override
  void dispose() {
    getStdNum();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: width,
            height: 150,
            color: AppColor.main,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 14, right: 14),
                child: Stack(
                  children: [
                    Container(
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
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'สวัสดี',
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: AppColor.mainText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'คุณ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: AppColor.mainText,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.firstName,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: AppColor.mainText,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.lastName,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: AppColor.mainText,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Container(
                                          height: 1,
                                          width: 320,
                                          color: Colors.grey.shade400),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text(
                                  'จำนวนนักเรียนบนรถ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.mainText,
                                  ),
                                ),
                                Text(
                                  string == '0' ? '0' : '$string',
                                  style: const TextStyle(
                                      fontSize: 28,
                                      color: AppColor.mainText,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            logout();
                          },
                          icon: const Icon(
                            Icons.more_vert_sharp,
                            color: AppColor.mainText,
                          )),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 50,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color: Colors.white,
              //         boxShadow: [
              //           const BoxShadow(
              //               color: Colors.transparent,
              //               spreadRadius: 0,
              //               offset: Offset(0, 0),
              //               blurRadius: 8),
              //           const BoxShadow(
              //               color: Color.fromARGB(255, 173, 173, 173),
              //               spreadRadius: 1,
              //               offset: Offset(1, 1),
              //               blurRadius: 8)
              //         ]),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: MenuButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/student');
                                  },
                                  title: const Text(
                                    'ข้อมูลนักเรียน',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.mainText),
                                  ),
                                  icon: const Icon(
                                    Icons.people_alt_rounded,
                                    size: 70,
                                    color: AppColor.main,
                                  ),
                                  width: width / 2.8,
                                  higth: width / 2.4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: MenuButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/location');
                                  },
                                  title: const Text(
                                    'ตำแหน่งรถ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.mainText),
                                  ),
                                  icon: const Icon(
                                    Icons.location_on,
                                    size: 70,
                                    color: AppColor.main,
                                  ),
                                  width: width / 2.8,
                                  higth: width / 2.4,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: MenuButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/adduser');
                                  },
                                  title: const Text(
                                    'เพิ่มผู้ใช้งาน',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.mainText),
                                  ),
                                  icon: const Icon(
                                    Icons.person_add_alt_rounded,
                                    size: 70,
                                    color: AppColor.main,
                                  ),
                                  width: width / 2.8,
                                  higth: width / 2.4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: MenuButton(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/report');
                                  },
                                  title: const Text(
                                    'การโดยสาร',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.mainText),
                                  ),
                                  icon: const Icon(
                                    Icons.fact_check,
                                    size: 70,
                                    color: AppColor.main,
                                  ),
                                  width: width / 2.8,
                                  higth: width / 2.4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  logout() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              // message: const Text(
              //   "คุณต้องการออกจากระบบหรือไม่?",
              //   style: TextStyle(fontSize: 20),
              // ),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Container(
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .dialogTheme
                                        .backgroundColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'เปลี่ยนแปลงเบอร์โทร',
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: AppColor.mainText),
                                      ),
                                      Form(
                                        key: _editkey,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          child: TextFormField(
                                              onSaved: (value) {
                                                phoneEdit = value!;
                                              },
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  prefixIcon: Icon(
                                                    Icons.edit,
                                                    color: Colors.grey,
                                                  )),
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ]),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColor.main),
                                                onPressed: () async {
                                                  final user;
                                                  if (_editkey.currentState!
                                                      .validate()) {
                                                    _editkey.currentState!
                                                        .save();
                                                    if (phoneEdit == '') {
                                                      return;
                                                    } else {
                                                      try {
                                                        await databaseReference
                                                            .child('users')
                                                            .child('user_data')
                                                            .child(
                                                                widget.user.uid)
                                                            .update({
                                                          'phone': phoneEdit,
                                                        });
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                    }
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'ยืนยัน',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.red),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'ยกเลิก',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  child: const Text(
                    "แก้ไข",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Container(
                  height: 0.1,
                  width: 100,
                  color: Colors.grey,
                ),
                CupertinoActionSheetAction(
                  onPressed: () async {
                    showConfirmLogout();
                  },
                  child: const Text(
                    "ออกจากระบบ",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
              // cancelButton: CupertinoActionSheetAction(
              //   child: const Text("ยกเลิก"),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // )
            ));
  }

  showConfirmLogout() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            message: const Text(
              "คุณต้องการออกจากระบบหรือไม่?",
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  AuthService auth = AuthService();
                  auth.logOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
                child: const Text(
                  "ยืนยัน",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text("ยกเลิก"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )));
  }
}

class MenuButton extends StatefulWidget {
  const MenuButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.width,
    required this.higth,
    // required this.color,
    // required this.backgroudColor,
    // required this.splashColor,
    required this.onTap,
  }) : super(key: key);

  final Text title;
  final Widget icon;
  final double width;
  final double higth;
  // final Color color;
  // final Color backgroudColor;
  // final Color splashColor;
  final VoidCallback onTap;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isElevated = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width + 16,
      height: widget.higth + 16,
      child: Center(
        child: GestureDetector(
          onTap: (() {
            setState(() {
              _isElevated = true;
            });
            widget.onTap();
          }),
          onTapUp: (detail) {
            setState(() {
              _isElevated = true;
            });
          },
          onTapCancel: () {
            setState(() {
              _isElevated = true;
            });
          },
          onTapDown: (details) {
            setState(() {
              _isElevated = false;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: _isElevated
                    ? [
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
                      ]
                    : [
                        const BoxShadow(
                            color: Colors.transparent,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                            blurRadius: 8),
                        const BoxShadow(
                            color: Color.fromARGB(255, 217, 217, 217),
                            spreadRadius: 1,
                            offset: Offset(1, 1),
                            blurRadius: 8)
                      ],
                borderRadius: const BorderRadius.all(Radius.circular(24))),
            height: _isElevated ? widget.higth : widget.higth - 3,
            width: _isElevated ? widget.width : widget.width - 3,
            child: FittedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: widget.width,
                    child: Center(child: widget.icon),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    // padding:
                    //     const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(99)),
                    child: widget.title,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
