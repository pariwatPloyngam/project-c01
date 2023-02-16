import 'package:flutter/material.dart';
import 'passwordField.dart';

class VerificationFields extends StatefulWidget {
  const VerificationFields({super.key});

  @override
  State<VerificationFields> createState() => _VerificationFieldsState();
}

class _VerificationFieldsState extends State<VerificationFields> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: TextField(
              controller: emailController,
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
            child: const PasswordField(),
          )
        ],
      ),
    );
  }
}
