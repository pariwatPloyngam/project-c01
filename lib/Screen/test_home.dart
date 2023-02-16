// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Screen/login_page.dart';

class TeacherPage extends StatelessWidget {
  final user;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  TeacherPage(
      {@required this.user,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi !',
              style: TextStyle(fontSize: 50),
            ),
            Text('Welcometo Teacher Page', style: TextStyle(fontSize: 30)),
            Text(firstName + lastName, style: TextStyle(fontSize: 20)),
            Text('Email: ${user.email}'),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

class UserPage extends StatelessWidget {
  final user;
  final String firstName;
  final String lastName;
  final String parentName;
  final String parentLastName;
  final String studenID;
  final String phoneNumber;
  final String tagID;

  UserPage({
    super.key,
    @required this.user,
    required this.firstName,
    required this.lastName,
    required this.parentName,
    required this.parentLastName,
    required this.studenID,
    required this.phoneNumber,
    required this.tagID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi !',
              style: TextStyle(fontSize: 50),
            ),
            Text('Welcome to User Page', style: TextStyle(fontSize: 30)),
            Text(firstName + lastName, style: TextStyle(fontSize: 20)),
            Text(parentName + parentLastName, style: TextStyle(fontSize: 20)),

            Text('Email: ${user.email}'),
            // Text('Email: ${user.uid}'),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

class DriverPage extends StatelessWidget {
  final user;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String carId;

  DriverPage(
      {@required this.user,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.carId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hi !',
              style: TextStyle(fontSize: 50),
            ),
            Text('Welcome to Driver Page', style: TextStyle(fontSize: 30)),
            Text(firstName + lastName, style: TextStyle(fontSize: 20)),
            Text('Car ID $carId', style: TextStyle(fontSize: 20)),
            Text('Telephone $phoneNumber', style: TextStyle(fontSize: 20)),
            Text('Email: ${user.email}'),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
