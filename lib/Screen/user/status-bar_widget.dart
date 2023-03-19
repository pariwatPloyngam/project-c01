import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Screen/login_page.dart';
import 'package:project_flutter/Screen/user/user_home_page.dart';
import 'package:project_flutter/Service/auth.dart';

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
  String? phoneEdit, nameEdit, lastNameEdit;
  String? phoneText, nameText, lastNameText;
  final _editkey = GlobalKey<FormState>();

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
          if (snapshot.hasData) {
            var data = snapshot.data.snapshot!.value;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
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
                    child: data == null
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.firstName} ${widget.lastName}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: AppColor.mainText,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'สถานะ : '
                                      '${(data['status'] == '1') || (data['status'] == '3') ? 'อยู่บนรถ' : (data['status'] == '2') || (data['status'] == '4') ? 'ลงจากรถเเล้ว' : 'ยังไม่ขึ้นรถ'}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColor.mainText,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (data['status'] == '1') ||
                                                  (data['status'] == '2')
                                              ? 'เวลาขึ้น ${data['ridefirst']} น.'
                                              : (data['status'] == '3') ||
                                                      (data['status'] == '4')
                                                  ? 'เวลาขึ้น ${data['ridesec']} '
                                                  : 'เวลาขึ้น -',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColor.mainText,
                                          ),
                                        ),
                                        Text(
                                          (data['status'] == '1') ||
                                                  (data['status'] == '2')
                                              ? 'เวลาลง ${data['dropfirst']} น.'
                                              : (data['status'] == '3') ||
                                                      (data['status'] == '4')
                                                  ? 'เวลาลง ${data['dropsec']} น.'
                                                  : 'เวลาลง -',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColor.mainText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Image.asset(
                                      (data['status'] == '1') ||
                                              (data['status'] == '3')
                                          ? 'assets/image/status-car.png'
                                          : (data['status'] == '2') ||
                                                  (data['status'] == '4')
                                              ? 'assets/image/status-school.png'
                                              : 'assets/image/status-home.png',
                                      scale: 5,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
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
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
                                                          setState(() {});
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
