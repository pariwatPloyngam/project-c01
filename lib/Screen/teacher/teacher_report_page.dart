import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_flutter/Component/color.dart';
import 'package:project_flutter/Screen/teacher/teacher_check_page.dart';
import 'package:project_flutter/Screen/teacher/teacher_record_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool selectWidget = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.main,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.mainText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: selectWidget == false
                                ? AppColor.mainIcon
                                : Colors.transparent,
                            width: 3))),
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        selectWidget = false;
                      });
                    },
                    icon: Icon(
                      Icons.today,
                      size: 24,
                      color: Colors.grey.shade700,
                    ),
                    label: Text(
                      'วันนี้',
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade800),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: selectWidget == true
                                ? AppColor.mainIcon
                                : Colors.transparent,
                            width: 3))),
                child: TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () {
                      setState(() {
                        selectWidget = true;
                      });
                    },
                    icon: Icon(
                      Icons.reorder_rounded,
                      size: 24,
                      color: Colors.grey.shade700,
                    ),
                    label: Text('บันทึก',
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade800))),
              ),
            ],
          ),
          Flexible(child: selectWidget == false ? Check() : Record())
        ],
      ),
    );
  }
}
