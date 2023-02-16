import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: SizedBox(
            width: width / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/image/bus.png'),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      'Wellcome',
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 30,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0, // shadow blur
                              color: Colors.black, // shadow color
                              offset: Offset(
                                  1.0, .0), // how much shadow will be shown
                            ),
                          ]),
                    ),
                    const Text(
                      'This is School bus Application',
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 18,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0, // shadow blur
                              color: Colors.black, // shadow color
                              offset: Offset(
                                  1.0, .0), // how much shadow will be shown
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.amber.shade200,
                        Colors.amber
                        //add more colors
                      ]),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey, //shadow for button
                        ) //blur radius of shadow
                      ]),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          fixedSize: Size(width / 1.5, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
                const SizedBox(height: 15),
                DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.amber.shade300,
                        Colors.amber.shade700
                        //add more colors
                      ]),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey, //shadow for button
                        ) //blur radius of shadow
                      ]),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          fixedSize: Size(width / 1.5, 50),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
