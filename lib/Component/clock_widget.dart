import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:project_flutter/Component/color.dart';

class ClockTH {
  static List<String> month = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ];
}

// class ClockWidget extends StatefulWidget {
//   const ClockWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _ClockWidgetState createState() => _ClockWidgetState();
// }

// class _ClockWidgetState extends State<ClockWidget> {
//   String _time = '00:00';
//   String _date = '1 มกราคม 2564';

//   Timer? _timer;

//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         final dateTime = DateTime.now();
//         _time = DateFormat('H:mm').format(dateTime);
//         _date =
//             '${dateTime.day} ${ClockTH.month[dateTime.month - 1]} ${dateTime.year + 543}';
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       width: 350,
//       height: 400,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             _time,
//             style: GoogleFonts.antonio(
//                 fontSize: 70,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).appBarTheme.foregroundColor),
//           ),
//           Text(
//             _date,
//             style: GoogleFonts.antonio(
//                 color: Theme.of(context).iconTheme.color, fontSize: 40),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ClockWidgetHorizontalStyle extends StatefulWidget {
  const ClockWidgetHorizontalStyle({
    Key? key,
  }) : super(key: key);

  @override
  _ClockWidgetHorizontalStyleState createState() =>
      _ClockWidgetHorizontalStyleState();
}

class _ClockWidgetHorizontalStyleState
    extends State<ClockWidgetHorizontalStyle> {
  Timer? _timer;
  String _timeStr = DateFormat('HH:mm').format(DateTime.now());
  String _dateStr =
      '${DateTime.now().day} ${ClockTH.month[DateTime.now().month - 1]} ${DateTime.now().year + 543}';

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final dateTime = DateTime.now();
        _timeStr = DateFormat('HH:mm').format(dateTime);
        _dateStr =
            '${dateTime.day} ${ClockTH.month[dateTime.month - 1]} ${dateTime.year + 543}';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _timeStr,
          style: GoogleFonts.antonio(
              fontSize: 40,
              color: AppColor.mainText,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          _dateStr,
          style: const TextStyle(fontSize: 28, color: AppColor.mainText),
        ),
      ],
    );
  }
}
