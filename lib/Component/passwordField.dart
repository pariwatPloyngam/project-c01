// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _ishidden = true;
  TextEditingController passwordController = TextEditingController();

  void _toggleVisibility() {
    setState(
      () {
        _ishidden = !_ishidden;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      cursorColor: Colors.amber,
      obscureText: _ishidden ? true : false,
      style: const TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_ishidden ? Icons.visibility_off : Icons.visibility),
          color: _ishidden ? Colors.grey.shade400 : Colors.amber.shade500,
          onPressed: _toggleVisibility,
        ),
        border: InputBorder.none,
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
