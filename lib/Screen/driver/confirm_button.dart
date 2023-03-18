import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Component/color.dart';

class confirmButton extends StatefulWidget {
  const confirmButton({
    super.key,
    required this.string,
  });

  final String? string;

  @override
  State<confirmButton> createState() => _confirmButtonState();
}

class _confirmButtonState extends State<confirmButton> {
  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseReference.child('access').child('confirm').onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.snapshot.value;

            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: data == 0
                            ? AppColor.main
                            : (widget.string == '0'
                                ? AppColor.main
                                : Colors.grey.shade200)),
                    onPressed: () async {
                      if (data == 0) {
                        await databaseReference.child('access').update({
                          'confirm': 1,
                        });
                      } else if (data == 1) {
                        await databaseReference.child('access').update({
                          'confirm': 0,
                        });
                      }
                    },
                    child: Text(
                      (data == 0) ? 'เริ่ม' : 'สิ้นสุด',
                      style: const TextStyle(
                          fontSize: 30, color: AppColor.mainText),
                    )));
          } else {
            return const SizedBox();
          }
        });
  }
}
