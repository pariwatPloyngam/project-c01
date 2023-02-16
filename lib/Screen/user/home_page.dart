// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Screen/login_page.dart';
import 'package:project_flutter/Service/auth.dart';

import '../login0ld.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Stack(
        children: [
          Container(
            width: width,
            height: heigth / 3,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.amber, Colors.amber.shade600])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 30),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset('assets/image/profile.png'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Wellcome',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Text('Mr.Somchai Yaimak',
                              style: TextStyle(fontSize: 24))
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            Icons.settings,
                            size: 30,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            showConfirmLogout();
                          },
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            Icons.logout_outlined,
                            size: 30,
                            color: Colors.white,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
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
                                color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.people_alt_rounded,
                            size: 70,
                            color: Colors.amber,
                          ),
                          width: width / 2.8,
                          higth: width / 2.8,
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
                                color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.location_on,
                            size: 70,
                            color: Colors.amber,
                          ),
                          width: width / 2.8,
                          higth: width / 2.8,
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
                                color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.person_add_alt_rounded,
                            size: 70,
                            color: Colors.amber,
                          ),
                          width: width / 2.8,
                          higth: width / 2.8,
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
                                color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.fact_check,
                            size: 70,
                            color: Colors.amber,
                          ),
                          width: width / 2.8,
                          higth: width / 2.8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showConfirmLogout() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
            message: Text("Would you like to log out?"),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  AuthService auth = AuthService();
                  auth.logOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text("Cancel"),
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
                            color: Color.fromARGB(255, 221, 221, 221),
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
