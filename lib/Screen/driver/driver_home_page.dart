// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Screen/driver/confirm_button.dart';
import 'package:project_flutter/Screen/login_page.dart';
import 'package:project_flutter/Service/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DriverPage extends StatefulWidget {
  final user;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String carId;

  const DriverPage(
      {super.key,
      @required this.user,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.carId});

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  final databaseReference = FirebaseDatabase.instance.ref();
  late String currentDate;
  bool isConfirm = false;
  String? string;
  final _editkey = GlobalKey<FormState>();
  String? phoneEdit, nameEdit, lastNameEdit;
  String? phoneText, nameText, lastNameText;

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
    return Builder(builder: (context) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              color: AppColor.main,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 14, right: 14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                Flexible(
                  child: StreamBuilder(
                    stream: databaseReference
                        .child('access')
                        .child(currentDate)
                        .onValue,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        // Get the data from the snapshot
                        var data = snapshot.data.snapshot.value;
                        List<dynamic> dataList = data?.values.toList() ?? [];

                        if (dataList.isEmpty) {
                          // Show a loading indicator if the dataList is empty
                          return const Expanded(
                              child: Center(
                                  child: Text(
                            'ยังไม่มีการโดยสารรถรับส่ง',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          )));
                        } else {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 14),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // ignore: prefer_const_literals_to_create_immutables
                                            boxShadow: [
                                              const BoxShadow(
                                                  color: Colors.transparent,
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 8),
                                              const BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 173, 173, 173),
                                                  spreadRadius: 1,
                                                  offset: Offset(1, 1),
                                                  blurRadius: 8)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16),
                                                child: CircleAvatar(
                                                    backgroundImage:
                                                        const AssetImage(
                                                            'assets/image/study1.jpg'),
                                                    radius: 25,
                                                    backgroundColor:
                                                        Colors.amber.shade200),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${dataList[index]['first_name']} ${dataList[index]['last_name']}",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            AppColor.mainText,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    'สถานะ : '
                                                    '${(dataList[index]['status'] == '1') || (dataList[index]['status'] == '3') ? 'อยู่บนรถ' : (dataList[index]['status'] == '2') || (dataList[index]['status'] == '4') ? 'ลงจากรถเเล้ว' : 'ยังไม่ขึ้นรถ'}',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: AppColor.mainText,
                                                    ),
                                                  ),
                                                  Text(
                                                    (dataList[index][
                                                                    'status'] ==
                                                                '1') ||
                                                            (dataList[index][
                                                                    'status'] ==
                                                                '2')
                                                        ? 'เวลาขึ้น ${dataList[index]['ridefirst']} น. เวลาลง ${dataList[index]['dropfirst']} น.'
                                                        : (dataList[index][
                                                                        'status'] ==
                                                                    '3') ||
                                                                (dataList[index]
                                                                        [
                                                                        'status'] ==
                                                                    '4')
                                                            ? 'เวลาขึ้น ${dataList[index]['ridesec']} น. เวลาลง ${dataList[index]['dropsec']} น.'
                                                            : 'เวลาขึ้น - เวลาลง -',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      color: AppColor.mainText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 20),
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.check_circle,
                                              size: 40,
                                              color: (dataList[index]
                                                              ['status'] ==
                                                          '1') ||
                                                      (dataList[index]
                                                              ['status'] ==
                                                          '3')
                                                  ? Colors.grey.shade200
                                                  : Colors.green,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColor.main,
                        ));
                      }
                    },
                  ),
                ),
                // Padding(
                //     padding: const EdgeInsets.all(12),
                //     child: StreamBuilder(
                //         stream: databaseReference
                //             .child('access')
                //             .child('confirm')
                //             .onValue,
                //         builder: (context, snapshot) {
                //           if (snapshot.hasData) {
                //             var data = snapshot.data!.snapshot.value;

                //             return SizedBox(
                //                 width: MediaQuery.of(context).size.width,
                //                 height: 60,
                //                 child: ElevatedButton(
                //                     style: ElevatedButton.styleFrom(
                //                         backgroundColor: data == 0
                //                             ? AppColor.main
                //                             : (string == '0'
                //                                 ? AppColor.main
                //                                 : Colors.grey.shade200)),
                //                     onPressed: () async {
                //                       if (data == 0) {
                //                         await databaseReference
                //                             .child('access')
                //                             .update({
                //                           'confirm': 1,
                //                         });
                //                       } else if (data == 1) {
                //                         await databaseReference
                //                             .child('access')
                //                             .update({
                //                           'confirm': 0,
                //                         });
                //                       }
                //                     },
                //                     child: Text(
                //                       (data == 0) ? 'เริ่ม' : 'สิ้นสุด',
                //                       style: const TextStyle(
                //                           fontSize: 30,
                //                           color: AppColor.mainText),
                //                     )));
                //           } else {
                //             return const SizedBox();
                //           }
                //         }))
              ],
            ),
          ],
        ),
      );
    });
  }

  logout() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                    databaseReference
                        .child("users")
                        .child("user_data")
                        .child(widget.user.uid)
                        .once()
                        .then((snapshot) {
                      Map<dynamic, dynamic> edit =
                          snapshot.snapshot.value as dynamic;

                      phoneText = edit['phone'];
                      nameText = edit['first_name'];
                      lastNameText = edit['last_name'];

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
                                          'แก้ไขข้อมูลส่วนตัว',
                                          style: TextStyle(
                                              fontSize: 26,
                                              color: AppColor.mainText,
                                              fontWeight: FontWeight.bold),
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
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: AppColor
                                                              .mainText),
                                                      initialValue: nameText,
                                                      onSaved: (value) {
                                                        nameEdit = value!;
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              prefixText:
                                                                  'ชื่อ : '),
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            10)
                                                      ]),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: AppColor
                                                              .mainText),
                                                      initialValue:
                                                          lastNameText,
                                                      onSaved: (value) {
                                                        lastNameEdit = value!;
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              prefixText:
                                                                  'นามสกุล : '),
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            10)
                                                      ]),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: AppColor
                                                              .mainText),
                                                      initialValue: phoneText,
                                                      onSaved: (value) {
                                                        phoneEdit = value!;
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              prefixText:
                                                                  'เบอร์โทรศัพท์ : '),
                                                      keyboardType: TextInputType.phone,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            10)
                                                      ]),
                                                ),
                                              ],
                                            ),
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              AppColor.main),
                                                  onPressed: () async {
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
                                                              .child(
                                                                  'user_data')
                                                              .child(widget
                                                                  .user.uid)
                                                              .update({
                                                            'phone': phoneEdit,
                                                            'first_name':
                                                                nameEdit,
                                                            'last_name':
                                                                lastNameEdit
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
                                                  style:
                                                      ElevatedButton.styleFrom(
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
                    });
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
                          builder: (context) => const LoginPage()), (route) {
                    return false;
                  });
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
