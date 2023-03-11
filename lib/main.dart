import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Screen/teacher/teacher_add_user.dart';

import 'package:project_flutter/Screen/teacher/teacher_location_page.dart';

import 'package:project_flutter/Screen/teacher/teacher_check_page.dart';
import 'package:project_flutter/Screen/login_page.dart';
import 'package:project_flutter/Screen/teacher/test.dart';
import 'package:project_flutter/Screen/test_regis.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/testre': (context) => const RegisterTest(),
        '/login': (context) => const LoginPage(),
        '/student': (context) => const StudentPage(),
        '/location': (context) => LocationPage(),
        '/adduser': (context) => const AddUserPage(),
        '/report': (context) => ReportPage(),
      },
    );
  }
}
