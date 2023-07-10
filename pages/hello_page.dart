// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:chatapp/components/items.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

class HelloPage extends StatefulWidget {
  const HelloPage({super.key});

  @override
  State<HelloPage> createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.immersive,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget helloText = Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
        child: Container(
          // color: Colors.pink,
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // hello text
              Expanded(flex: 1, child: Container()),
              Text(
                // "Let's Get\nStarted",
                // "Bee yourself with Buzz",
                "Welcome\nin Buzz",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
                // style: GoogleFonts.montserrat(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 55,
                //   color: Colors.white,
                // ),
              ),

              Expanded(flex: 2, child: Container()),
              // Text("Bee yourself with Buzz",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 18,
              //         fontWeight: FontWeight.w300)),
              // Expanded(flex: 2, child: Container()),
              MyButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RegisterPage()));
                  },
                  text: "Join now",
                  textColor: Colors.blue.shade800,
                  buttonColor: Colors.white),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginPage()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      height: 30,
                      child: Center(
                        child: Text(
                          "    Log in now       ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );

    Widget helloPhotos1 = Transform.rotate(
      angle: -15 * pi / 180,
      child: Container(
        color: Colors.transparent,
        // height: MediaQuery.of(context).size.height * 0.5,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pic/${26}.png"),
              // fit: BoxFit.scaleDown,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
    Widget helloPhotos2 = Transform.rotate(
      angle: 12 * pi / 180,
      child: Container(
        color: Colors.transparent,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pic/${12}.png"),
              // fit: BoxFit.scaleDown,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
    Widget helloPhotos3 = Transform.rotate(
      angle: -4 * pi / 180,
      child: Container(
        color: Colors.transparent,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pic/${16}.png"),
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
    Widget helloPhotos4 = Transform.rotate(
      angle: 6 * pi / 180,
      child: Container(
        color: Colors.transparent,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pic/${2}.png"),
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );

    Widget helloPhotos = SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Container(),
          Positioned(
            bottom: 20,
            right: -10,
            child: helloPhotos1,
          ),
          Positioned(
            bottom: 25,
            left: -5,
            child: helloPhotos2,
          ),
          Positioned(
            bottom: 220,
            right: MediaQuery.of(context).size.width * 0.5 + 20,
            child: helloPhotos3,
          ),
          Positioned(
            bottom: 260,
            right: MediaQuery.of(context).size.width * 0.5 - 130,
            child: helloPhotos4,
          ),
        ],
      ),
    );

    return Scaffold(
      // appBar: AppBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade400,
                Colors.blue.shade900,
              ],
            ),
          ),
          child: Column(
            children: [
              helloPhotos,
              helloText,
            ],
          )),
    );
  }
}
