// ignore_for_file: unused_field, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/Screen/login_page.dart';

class RegisterTest extends StatefulWidget {
  const RegisterTest({super.key});

  @override
  State<RegisterTest> createState() => _RegisterTestState();
}

class _RegisterTestState extends State<RegisterTest> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String _email, _password, _firstName, _lastName;
  String? selectedRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) =>
                      value == null ? 'First name can\'t be empty' : null,
                  onSaved: (value) => _firstName = value!,
                  decoration: const InputDecoration(labelText: 'First name'),
                ),
                TextFormField(
                  validator: (value) =>
                      value == null ? 'Last name can\'t be empty' : null,
                  onSaved: (value) => _lastName = value!,
                  decoration: const InputDecoration(labelText: 'Last name'),
                ),
                TextFormField(
                  validator: (value) =>
                      value == null ? 'Email can\'t be empty' : null,
                  onSaved: (value) => _email = value!,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  validator: (value) =>
                      value == null ? 'Password can\'t be empty' : null,
                  onSaved: (value) => _password = value!,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                RadioListTile(
                  title: const Text('User'),
                  value: 'user',
                  groupValue: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Teacher'),
                  value: 'teacher',
                  groupValue: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Driver'),
                  value: 'driver',
                  groupValue: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Register'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var user = (await _auth.createUserWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        final FirebaseDatabase database = FirebaseDatabase.instance;
        await database.ref().child('users').child(user!.uid).set({
          'first_name': _firstName,
          'last_name': _lastName,
          'email': user.email,
        });
        await database
            .ref()
            .child('user_roles')
            .child(user.email!.replaceAll('.', ','))
            .set('$selectedRole');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } catch (e) {
        print(e);
      }
    }
  }
}
