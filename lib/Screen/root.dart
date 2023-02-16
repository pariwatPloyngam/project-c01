import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_flutter/Screen/teacher/teacher_home_page.dart';
import 'package:project_flutter/Screen/login0ld.dart';
import 'package:project_flutter/Screen/login_page.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  // final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return
        // auth.currentUser != null ? const HomePage() :
        LoginPage();
  }
}
