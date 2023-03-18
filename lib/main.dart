import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_flutter/Screen/teacher/teacher_add_user.dart';
import 'package:project_flutter/Screen/teacher/teacher_location_page.dart';
import 'package:project_flutter/Screen/teacher/teacher_studentList_page.dart';
import 'package:project_flutter/Screen/login_page.dart';
import 'package:project_flutter/Screen/teacher/teacher_report_page.dart';
import 'package:scaled_app/scaled_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  // runAppScaled(MyApp(), scaleFactor: (deviceSize) {
  //   // screen width used in your UI design
  //   const double widthOfDesign = 375;
  //   return deviceSize.width / widthOfDesign;
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/student': (context) => const StudentPage(),
        '/location': (context) => const LocationPage(),
        '/adduser': (context) => const AddUserPage(),
        '/report': (context) => const ReportPage(),
      },
    );
  }
}
