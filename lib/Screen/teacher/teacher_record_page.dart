import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/Component/clock_widget.dart';
import 'package:project_flutter/Component/color.dart';

class Record extends StatefulWidget {
  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  final databaseReference = FirebaseDatabase.instance.ref();
  Set<int> selectedIndex = {};

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return StreamBuilder(
        stream: databaseReference.child('access').onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data.snapshot.value;
            List<dynamic> dataList = data?.values.toList() ?? [];
            List<dynamic> keyList = data?.keys.toList() ?? [];
            if (keyList.isEmpty) {
              return const Center(
                child: Text('ยังไม่มีการบันทึกข้อมูล'),
              );
            } else {
              keyList.sort((a, b) => b.compareTo(a));
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                  itemCount: keyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var key = keyList[index];
                    var users = data[key];
                    List<dynamic> userList = users?.values.toList() ?? [];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedIndex.contains(index)) {
                            selectedIndex.remove(index);
                          } else {
                            selectedIndex.add(index);
                          }
                        });
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                // ignore: prefer_const_literals_to_create_immutables
                                boxShadow: [
                                  const BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 0,
                                      offset: Offset(0, 0),
                                      blurRadius: 8),
                                  const BoxShadow(
                                      color: Color.fromARGB(255, 185, 185, 185),
                                      spreadRadius: 1,
                                      offset: Offset(2, 2),
                                      blurRadius: 8)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        key,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.mainText),
                                      ),
                                      Icon(
                                        selectedIndex.contains(index)
                                            ? Icons.arrow_drop_up_rounded
                                            : Icons.arrow_drop_down_rounded,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                ),
                                selectedIndex.contains(index)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: userList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var user = userList[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      user?['first_name'],
                                                      style: const TextStyle(
                                                          color:
                                                              AppColor.mainText,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      user?['last_name'],
                                                      style: const TextStyle(
                                                          color:
                                                              AppColor.mainText,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'ไปโรงเรียน',
                                                  style: const TextStyle(
                                                      color: AppColor.mainText,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'เวลาขึ้น ${user?['ridefirst']} น.',
                                                      style: const TextStyle(
                                                          color:
                                                              AppColor.mainText,
                                                          fontSize: 18),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'เวลาลง ${user?['dropfirst']} น.',
                                                      style: const TextStyle(
                                                          color:
                                                              AppColor.mainText,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'กลับบ้าน',
                                                  style: const TextStyle(
                                                      color: AppColor.mainText,
                                                      fontSize: 20),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'เวลาขึ้น ${user?['ridesec']} น.',
                                                      style: const TextStyle(
                                                          color:
                                                              AppColor.mainText,
                                                          fontSize: 18),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'เวลาลง ${user?['dropsec']} น.',
                                                      style: const TextStyle(
                                                          color:
                                                              AppColor.mainText,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Container(
                                                    width: 320,
                                                    height: 1,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else {
            return Container(
                child: const Center(
                    child: CircularProgressIndicator(
              color: Colors.amber,
            )));
          }
        },
      );
    });
  }
}
