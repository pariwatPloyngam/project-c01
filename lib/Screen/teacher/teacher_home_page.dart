// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber.shade500,
      //   elevation: 0,
      //   title: const Text('Home Page'),
      // ),
      // drawer: Drawer(
      //   backgroundColor: Colors.amber.shade500,
      //   child: Column(
      //     children: [],
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: const [0.0, 1.0],
                colors: [AppColor.mainIcon, Colors.amber.shade200])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'สวัสดี',
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text('คุณ ${widget.firstName} ${widget.lastName}',
                      style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
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
                                  'STUDENT',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mainText),
                                ),
                                icon: const Icon(
                                  Icons.people_alt_rounded,
                                  size: 70,
                                  color: AppColor.mainIcon,
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
                                  'LOCATION',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mainText),
                                ),
                                icon: const Icon(
                                  Icons.location_on,
                                  size: 70,
                                  color: AppColor.mainIcon,
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
                                  'ADD USER',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mainText),
                                ),
                                icon: const Icon(
                                  Icons.person_add_alt_rounded,
                                  size: 70,
                                  color: AppColor.mainIcon,
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
                                  'REPORT',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mainText),
                                ),
                                icon: const Icon(
                                  Icons.fact_check,
                                  size: 70,
                                  color: AppColor.mainIcon,
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
      ),
    );
  }

  showConfirmLogout() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            message: const Text("Would you like to log out?"),
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
                  "Log Out",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text("Cancel"),
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
                            color: Color.fromARGB(255, 189, 167, 97),
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
                            color: Color.fromARGB(255, 214, 214, 214),
                            spreadRadius: 1,
                            offset: Offset(1, 1),
                            blurRadius: 3)
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
