import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/Component/clock_widget.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Screen/login_page.dart';

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
                              getStdNum();
                            },
                            icon: const Icon(
                              Icons.settings,
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
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 14),
                                  child: Container(
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
                                                backgroundImage: const AssetImage(
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
                                                    color: AppColor.mainText,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "สถานะ : "
                                                '${(dataList[index]['status'] == '1' ? 'อยู่บนรถ' : 'ลงจากรถเเล้ว')}',
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
              ],
            ),
          ],
        ),
      );
    });
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}

// Padding(
            //   padding: const EdgeInsets.only(top: 50, left: 14, right: 14),
            //   child: Stack(
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width,
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(10),
            //             // ignore: prefer_const_literals_to_create_immutables
            //             boxShadow: [
            //               const BoxShadow(
            //                   color: Colors.transparent,
            //                   spreadRadius: 0,
            //                   offset: Offset(0, 0),
            //                   blurRadius: 8),
            //               const BoxShadow(
            //                   color: Color.fromARGB(255, 173, 173, 173),
            //                   spreadRadius: 1,
            //                   offset: Offset(1, 1),
            //                   blurRadius: 8)
            //             ]),
            //         child: Padding(
            //           padding: const EdgeInsets.all(18.0),
            //           child: Column(
            //             children: [
            //               Row(
            //                 children: [
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       const Text(
            //                         'สวัสดี',
            //                         style: TextStyle(
            //                             fontSize: 22,
            //                             color: AppColor.mainText,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                       Row(
            //                         children: [
            //                           const Text(
            //                             'คุณ',
            //                             style: TextStyle(
            //                                 fontSize: 20,
            //                                 color: AppColor.mainText,
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                           const SizedBox(
            //                             width: 10,
            //                           ),
            //                           Text(
            //                             widget.firstName,
            //                             style: const TextStyle(
            //                                 fontSize: 20,
            //                                 color: AppColor.mainText,
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                           const SizedBox(
            //                             width: 10,
            //                           ),
            //                           Text(
            //                             widget.lastName,
            //                             style: const TextStyle(
            //                                 fontSize: 20,
            //                                 color: AppColor.mainText,
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                         ],
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             vertical: 12),
            //                         child: Container(
            //                             height: 1,
            //                             width: 320,
            //                             color: Colors.grey.shade400),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                 // ignore: prefer_const_literals_to_create_immutables
            //                 children: [
            //                   const Text(
            //                     'จำนวนนักเรียนบนรถ',
            //                     style: TextStyle(
            //                       fontSize: 20,
            //                       color: AppColor.mainText,
            //                     ),
            //                   ),
            //                   Text(
            //                     countStd == null ? '0' : countStd.toString(),
            //                     style: TextStyle(
            //                         fontSize: 28,
            //                         color: AppColor.mainText,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //       Align(
            //         alignment: Alignment.centerRight,
            //         child: IconButton(
            //             onPressed: () {},
            //             icon: const Icon(
            //               Icons.settings,
            //               color: AppColor.mainText,
            //             )),
            //       )
            //     ],
            //   ),
            // ),
