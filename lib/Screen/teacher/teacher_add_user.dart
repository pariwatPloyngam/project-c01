// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_flutter/Screen/login_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  String _value = 'สแกนคีย์การ์ด';
  bool autoClose = true;
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  late Timer _timer;
  var status = 1;
  late String email,
      password,
      firstName,
      lastName,
      parentName,
      parentLastName,
      id,
      phone,
      carId,
      tagID;

  void insertCardFunction() {
    final database = FirebaseDatabase.instance.ref();
    database.ref.child('status').set('1');
    database.ref.child('register').get().then((DataSnapshot snapshot) {
      String tagRfid = snapshot.value as String;
      if (tagRfid.isNotEmpty) {
        // closeDialog();
        // print('$tagRfid');
        _timer = Timer(const Duration(seconds: 2), () {
          setState(() {
            _value = tagRfid;
          });
          Navigator.of(context).pop();
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          return insertCardFunction();
        });
        print(' " " ');
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ignore: prefer_const_constructors
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: Colors.amber,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          (status == 1)
                              ? 'นักเรียน'
                              : (status == 2)
                                  ? 'อาจารย์'
                                  : 'คนขับรถ',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                        const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.amber,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("นักเรียน/ผู้ปกครอง"),
                  ),
                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("อาจารย์"),
                  ),
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text("คนขับรถ"),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 1) {
                  setState(() {
                    status = value;
                  });
                } else if (value == 2) {
                  setState(() {
                    status = value;
                  });
                } else if (value == 3) {
                  setState(() {
                    status = value;
                  });
                }
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 250,
                child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Image.asset('assets/image/signup.jpg')),
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
                      child: (status == 1)
                          ? userForm()
                          : (status == 2)
                              ? teacherForm()
                              : driverForm(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
                child: RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amber,
                  controller: btnController,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    (status == 1)
                        ? _userSubmit()
                        : (status == 2)
                            ? _teacherSubmit()
                            : _driverSubmit();
                  },
                  child: const Text("Register",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column teacherForm() {
    return Column(
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
              validator: (value) {
                return value == null ? 'First name can\'t be empty' : null;
              },
              onSaved: (value) {
                firstName = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'ชื่อ',
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.name),
        ),
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
              validator: (value) {
                return value == null ? 'Last name can\'t be empty' : null;
              },
              onSaved: (value) {
                lastName = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'นามสกุล',
                  prefixIcon: Icon(
                    Icons.people_alt_outlined,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.name),
        ),
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
              validator: (value) {
                return value == null ? 'Student ID ID can\'t be empty' : null;
              },
              onSaved: (value) {
                phone = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'เบอร์โทรศัพท์',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.phone),
        ),
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
              validator: (value) {
                return value == null ? 'Email can\'t be empty' : null;
              },
              onSaved: (value) {
                email = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'อีเมลล์',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.emailAddress),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) {
              return value == null ? 'Password can\'t be empty' : null;
            },
            onSaved: (value) {
              password = value!;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'รหัสผ่าน',
                prefixIcon: Icon(
                  Icons.key,
                  color: Colors.grey,
                )),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Column userForm() {
    return Column(
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
              validator: (value) {
                return value == null ? 'First name can\'t be empty' : null;
              },
              onSaved: (value) {
                firstName = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'ชื่อ',
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.name),
        ),
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
            validator: (value) {
              return value == null ? 'Last name can\'t be empty' : null;
            },
            onSaved: (value) {
              lastName = value!;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'นามสกุล',
                prefixIcon: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.grey,
                )),
            keyboardType: TextInputType.name,
          ),
        ),
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
              validator: (value) {
                return value == null ? 'First name can\'t be empty' : null;
              },
              onSaved: (value) {
                parentName = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'ชื่อผู้ปกครอง',
                  prefixIcon: Icon(
                    Icons.people_outline,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.name),
        ),
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
              validator: (value) {
                return value == null ? 'First name can\'t be empty' : null;
              },
              onSaved: (value) {
                parentLastName = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'นามสกุลผู้ปกครอง',
                  prefixIcon: Icon(
                    Icons.people_rounded,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.name),
        ),
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
              validator: (value) {
                return value == null ? 'Student ID ID can\'t be empty' : null;
              },
              onSaved: (value) {
                id = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'รหัสนักศึกษา',
                  prefixIcon: Icon(
                    Icons.assignment_ind_outlined,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.number),
        ),
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
              validator: (value) {
                return value == null ? 'First name can\'t be empty' : null;
              },
              onSaved: (value) {
                phone = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'เบอร์โทรผู้ปกครอง',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.phone),
        ),
        Container(
          height: 80,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.style_outlined, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Text(
                    _value,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ),
                Container(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.wifi,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final database = FirebaseDatabase.instance.ref();
                      database.ref.child('register').set('');
                      database.ref.child('status').set('1');
                      showDialog(
                          context: context,
                          builder: (BuildContext builderContext) {
                            insertCardFunction();
                            return Dialog(
                              child: SizedBox(
                                width: 300,
                                height: 350,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: const Text(
                                        'สแกนคีย์การ์ดของท่าน',
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                    SizedBox(
                                        width: 300,
                                        height: 300,
                                        child: Lottie.asset(
                                            'assets/lottie/scan.json'))
                                  ],
                                ),
                              ),
                            );
                            // return const AlertDialog(
                            //   backgroundColor: Colors.amber,
                            //   title: Text('Title'),
                            //   content: SingleChildScrollView(
                            //     child: Text('Content'),
                            //   ),
                            // );
                          }).then((val) {
                        if (_timer.isActive) {
                          _timer.cancel();
                        }
                      });
                      // final database = FirebaseDatabase.instance.ref();
                      // database.ref.child('status').set('1');
                      // database.ref
                      //     .child('register')
                      //     .get()
                      //     .then((DataSnapshot snapshot) {
                      //   String tagRfid = snapshot.value as String;
                      // });
                      // _openDialog();
                      // _getValueFormFirebase();

                      //  showDialog(
                      //     useRootNavigator: false,
                      //     useSafeArea: true,
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //         backgroundColor: Colors.white,
                      //         content: Text('fjkghgkdfjghkjdf'),
                      //       );
                      //     });
                    },
                  ),
                )
              ],
            ),
          ),
          // child: TextFormField(
          //   validator: (value) {
          //     return value == null ? 'First name can\'t be empty' : null;
          //   },
          //   onSaved: (value) {
          //     tagID = value!;
          //   },
          //   // initialValue: itag,
          //   decoration: const InputDecoration(
          //     border: InputBorder.none,
          //     labelText: 'สแกนคีย์การ์ด',
          //     prefixIcon: Icon(
          //       Icons.style_outlined,
          //       color: Colors.grey,
          //     ),
          //     suffixIcon: IconButton(
          //       icon: Icon(Icons.visibility),
          //       color: Colors.amber,
          //       onPressed: getdata,
          //     ),
          //   ),
          // ),
        ),
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
              validator: (value) {
                return value == null ? 'Email can\'t be empty' : null;
              },
              onSaved: (value) {
                email = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'อีเมลล์',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.emailAddress),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) {
              return value == null ? 'Password can\'t be empty' : null;
            },
            onSaved: (value) {
              password = value!;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'รหัสผ่าน',
              prefixIcon: Icon(
                Icons.key,
                color: Colors.grey,
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Column driverForm() {
    return Column(
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
              validator: (value) {
                return value == null ? 'First name can\'t be empty' : null;
              },
              onSaved: (value) {
                firstName = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'ชื่อ',
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.name),
        ),
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
              validator: (value) {
                return value == null ? 'Last name can\'t be empty' : null;
              },
              onSaved: (value) {
                lastName = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'นามสกุล',
                  prefixIcon: Icon(
                    Icons.people_alt_outlined,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.name),
        ),
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
              validator: (value) {
                return value == null ? 'Student ID ID can\'t be empty' : null;
              },
              onSaved: (value) {
                carId = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'ทะเบียนรถ',
                  prefixIcon: Icon(
                    Icons.directions_bus,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.text),
        ),
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
              validator: (value) {
                return value == null ? 'Student ID ID can\'t be empty' : null;
              },
              onSaved: (value) {
                phone = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'เบอร์โทรศัพท์',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.phone),
        ),
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
              validator: (value) {
                return value == null ? 'Email can\'t be empty' : null;
              },
              onSaved: (value) {
                email = value!;
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'อีเมลล์',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.grey,
                  )),
              keyboardType: TextInputType.emailAddress),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) {
              return value == null ? 'Password can\'t be empty' : null;
            },
            onSaved: (value) {
              password = value!;
            },
            decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'รหัสผ่าน',
                prefixIcon: Icon(
                  Icons.key,
                  color: Colors.grey,
                )),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
        ),
      ],
    );
  }

  void _teacherSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var user = (await _auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user;
        final FirebaseDatabase database = FirebaseDatabase.instance;
        await database
            .ref()
            .child('users')
            .child('user_data')
            .child(user!.uid)
            .set({
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'email': user.email,
          'role': 'teacher'
        });
        await database
            .ref()
            .child('users')
            .child('user_roles')
            .child(user.email!.replaceAll('.', ','))
            .set('teacher');
        btnController.success();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } catch (e) {
        btnController.reset();
        print(e);
      }
    }
  }

  void _userSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var user = (await _auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user;
        final FirebaseDatabase database = FirebaseDatabase.instance;
        await database
            .ref()
            .child('users')
            .child('user_data')
            .child(user!.uid)
            .set({
          'first_name': firstName,
          'last_name': lastName,
          'parent_name': parentName,
          'parent_lastname': parentLastName,
          'id': id,
          'phone': phone,
          'tagid': _value,
          'email': user.email,
          'role': 'user'
        });
        await database
            .ref()
            .child('users')
            .child('user_roles')
            .child(user.email!.replaceAll('.', ','))
            .set('user');
        await database
            .ref()
            .child('users')
            .child('user_id')
            .child(_value)
            .set(user.uid);
        await database.ref().child('status').set('2');
        await database.ref().child('register').set('');
        btnController.success();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } catch (e) {
        btnController.reset();
        print(e);
      }
    }
  }

  void _driverSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var user = (await _auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user;
        final FirebaseDatabase database = FirebaseDatabase.instance;
        await database
            .ref()
            .child('users')
            .child('user_data')
            .child(user!.uid)
            .set({
          'first_name': firstName,
          'last_name': lastName,
          'car_id': carId,
          'phone': phone,
          'email': user.email,
          'role': 'driver'
        });
        await database
            .ref()
            .child('users')
            .child('user_roles')
            .child(user.email!.replaceAll('.', ','))
            .set('driver');
        btnController.success();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } catch (e) {
        btnController.reset();
        print(e);
      }
    }
  }
}
