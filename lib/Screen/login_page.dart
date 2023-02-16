// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Screen/teacher/teacher_home_page.dart';
import 'package:project_flutter/Screen/test_home.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _ishidden = true;
  @override
  void _toggleVisibility() {
    setState(
      () {
        _ishidden = !_ishidden;
      },
    );
  }

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 300,
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image.asset('assets/image/login.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20.0,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              validator: (value) => value == null
                                  ? 'Email can\'t be empty'
                                  : null,
                              onSaved: (value) => _email = value!,
                              cursorColor: Colors.amber,
                              style: const TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email or Phone number",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(),
                            child: TextFormField(
                              validator: (value) => value == null
                                  ? 'Password can\'t be empty'
                                  : null,
                              onSaved: (value) => _password = value!,
                              cursorColor: Colors.amber,
                              style: const TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(_ishidden
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: _ishidden
                                      ? Colors.grey.shade400
                                      : Colors.amber.shade500,
                                  onPressed: _toggleVisibility,
                                ),
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              obscureText: _ishidden ? true : false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedLoadingButton(
                      loaderStrokeWidth: 3,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.amber,
                      controller: btnController,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        _submit();
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var user = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        final database = FirebaseDatabase.instance.ref();
        final snapshot = await database.ref
            .child('users')
            .child('user_data')
            .child(user!.uid)
            .get();
        var data = snapshot.value as Map; //ข้อมูล user_data

        await database.ref
            .child('users')
            .child('user_roles')
            .child(user.email!.replaceAll('.', ','))
            .get()
            .then((DataSnapshot snapshot) {
          String role = snapshot.value as String; // ระบุระดับ user

          if (role == 'teacher') {
            // ถ้าครูล็อกอิน
            String firstName = data['first_name'];
            String lastName = data['last_name'];
            String phoneNumber = data['phone'];
            btnController.success();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TeacherHomePage(
                          firstName: firstName,
                          lastName: lastName,
                          user: user,
                          phoneNumber: phoneNumber,
                        )));
          } else if (role == "user") {
            // ถ้าค user ล็อกอิน
            String firstName = data['first_name'];
            String lastName = data['last_name'];
            String parentName = data['parent_name'];
            String parentLastName = data['parent_lastname'];
            String studentID = data['id'];
            String phoneNumber = data['phone'];
            String tagId = data['tagid'];
            btnController.success();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => UserPage(
                          firstName: firstName,
                          lastName: lastName,
                          parentName: parentName,
                          parentLastName: parentLastName,
                          user: user,
                          phoneNumber: phoneNumber,
                          studenID: studentID,
                          tagID: tagId,
                        )));
          } else {
            // ถ้าคนขับรถล็อกอิน
            btnController.success();
            String firstName = data['first_name'];
            String lastName = data['last_name'];
            String phoneNumber = data['phone'];
            String carID = data['car_id'];
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => DriverPage(
                          firstName: firstName,
                          lastName: lastName,
                          user: user,
                          carId: carID,
                          phoneNumber: phoneNumber,
                        )));
          }
        });
      } catch (e) {
        btnController.reset();

        print(e);
      }
    }
  }
}
