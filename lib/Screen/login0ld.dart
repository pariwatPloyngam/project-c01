// // ignore_for_file: public_member_api_docs, sort_constructors_first
// // ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers, use_build_context_synchronously

// import 'dart:convert';

// import 'package:animate_do/animate_do.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// import 'package:project_flutter/Component/custom_dialog.dart';
// import 'package:project_flutter/Screen/home_page.dart';
// import 'package:project_flutter/Service/auth.dart';

// final databaseReference = FirebaseDatabase.instance.ref();

// class User {
//   String email;
//   String parentName;
//   String password;
//   String status;
//   String studentName;

//   User({
//     required this.email,
//     required this.parentName,
//     required this.password,
//     required this.status,
//     required this.studentName,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'email': email,
//       'parentName': parentName,
//       'password': password,
//       'status': status,
//       'studentName': studentName,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       email: map['email'] as String,
//       parentName: map['parentName'] as String,
//       password: map['password'] as String,
//       status: map['status'] as String,
//       studentName: map['studentName'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) =>
//       User.fromMap(json.decode(source) as Map<String, dynamic>);

//   User copyWith({
//     String? email,
//     String? parentName,
//     String? password,
//     String? status,
//     String? studentName,
//   }) {
//     return User(
//       email: email ?? this.email,
//       parentName: parentName ?? this.parentName,
//       password: password ?? this.password,
//       status: status ?? this.status,
//       studentName: studentName ?? this.studentName,
//     );
//   }

//   @override
//   String toString() {
//     return 'User(email: $email, parentName: $parentName, password: $password, status: $status, studentName: $studentName)';
//   }

//   @override
//   bool operator ==(covariant User other) {
//     if (identical(this, other)) return true;

//     return other.email == email &&
//         other.parentName == parentName &&
//         other.password == password &&
//         other.status == status &&
//         other.studentName == studentName;
//   }

//   @override
//   int get hashCode {
//     return email.hashCode ^
//         parentName.hashCode ^
//         password.hashCode ^
//         status.hashCode ^
//         studentName.hashCode;
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   late DatabaseReference _userRef;

//   bool isloading = false;
//   bool _ishidden = true;
//   AuthService service = AuthService();

//   @override
//   void initState() {
//     _userRef = _database.ref().child('user');
//     Future.delayed(const Duration(seconds: 5), () {
//       setState(() {
//         isloading = true;
//       });
//     });
//     super.initState();
//   }

//   void _toggleVisibility() {
//     setState(
//       () {
//         _ishidden = !_ishidden;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var heigth = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: (isloading == false)
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 300,
//                     child: Container(
//                       child: Container(
//                         child: _animateLogo(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 300,
//                     child: Container(
//                       margin: const EdgeInsets.only(top: 50),
//                       child: Container(
//                         child: Image.asset('assets/image/login.jpg'),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             // ignore: prefer_const_literals_to_create_immutables
//                             boxShadow: [
//                               const BoxShadow(
//                                 color: Color.fromRGBO(143, 148, 251, .2),
//                                 blurRadius: 20.0,
//                                 offset: Offset(0, 10),
//                               )
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                                 child: TextField(
//                                   controller: emailController,
//                                   cursorColor: Colors.amber,
//                                   style: const TextStyle(color: Colors.black54),
//                                   decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: "Email or Phone number",
//                                     hintStyle:
//                                         TextStyle(color: Colors.grey[400]),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextField(
//                                   controller: passwordController,
//                                   cursorColor: Colors.amber,
//                                   obscureText: _ishidden ? true : false,
//                                   style: const TextStyle(color: Colors.black54),
//                                   decoration: InputDecoration(
//                                     suffixIcon: IconButton(
//                                       icon: Icon(_ishidden
//                                           ? Icons.visibility_off
//                                           : Icons.visibility),
//                                       color: _ishidden
//                                           ? Colors.grey.shade400
//                                           : Colors.amber.shade500,
//                                       onPressed: _toggleVisibility,
//                                     ),
//                                     border: InputBorder.none,
//                                     hintText: "Password",
//                                     hintStyle: TextStyle(
//                                       color: Colors.grey[400],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // ignore: prefer_const_constructors
//                         SizedBox(
//                           height: 10,
//                         ),
//                         DecoratedBox(
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(colors: [
//                                 Colors.amber.shade200,
//                                 Colors.amber
//                                 //add more colors
//                               ]),
//                               borderRadius: BorderRadius.circular(50),
//                               boxShadow: const <BoxShadow>[
//                                 BoxShadow(
//                                   color: Colors.grey, //shadow for button
//                                 ) //blur radius of shadow
//                               ]),
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   surfaceTintColor: Colors.transparent,
//                                   shadowColor: Colors.transparent,
//                                   fixedSize: Size(width, 50),
//                                   shape: const RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(50)))),
//                               onPressed: () async {
//                                 databaseReference
//                                     .child("user")
//                                     .once()
//                                     .then((snapshot) {
//                                   final userData = Map<String, dynamic>.from(
//                                       snapshot.snapshot as Map);
//                                   bool isLoginSuccess = false;
//                                   User user;
//                                 });
//                                 // // Navigator.pushNamed(context, '/home');
//                                 // var res = await service.signInWithEmailPassword(
//                                 //     emailController.text,
//                                 //     passwordController.text);
//                                 // if (res["status"] == false) {
//                                 //   showDialog(
//                                 //       context: context,
//                                 //       builder: (BuildContext context) {
//                                 //         return CustomDialogBox(
//                                 //           title: "Login",
//                                 //           descriptions: res["message"],
//                                 //         );
//                                 //       });
//                                 // } else {
//                                 //   Navigator.of(context).pushAndRemoveUntil(
//                                 //       MaterialPageRoute(
//                                 //           builder: (context) =>
//                                 //               const HomePage()),
//                                 //       (route) => false);
//                                 // }
//                               },
//                               child: const Text(
//                                 'Log In',
//                                 style: TextStyle(fontSize: 20),
//                               )),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//     );
//   }
// }

// Widget _animateLogo() {
//   return Container(
//       child: FadeIn(
//     animate: true,
//     duration: const Duration(seconds: 2),
//     // child: FadeOut(
//     //   animate: true,
//     //   delay: Duration(seconds: 2),
//     //   duration: Duration(seconds: 1),

//     // Just change the Image.asset widget to anything you want to fade in/out:
//     child: Image.asset(
//       "assets/image/bus.png",
//       height: 300,
//       width: 300,
//       fit: BoxFit.contain,
//     ), //Image.asset
//   ) // FadeOut
//       // ),
//       );
// }
