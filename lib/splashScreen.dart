import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gourab_das_internship_app/screen_one.dart';

class SplashScreen extends StatefulWidget {
 SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

double turn1 = 0.0;
double turn2 = 0.0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(microseconds: 500),(){
    setState(() {
      turn1 = 4.0;
      turn2 = 3.0;
    });
    });

     Timer(
  const Duration(seconds: 3),
  () {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
  },
);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          color: const Color.fromARGB(255, 243, 236, 236),
          child: Text("Demo ⚙️ App by Gourab Das",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),
        ),
         Positioned(
          top: 10,left: -20,
          child: AnimatedRotation(turns: turn1, duration: Duration(seconds: 4), child: Text("⚙️",style: TextStyle(fontSize: 50),),)),

         Positioned(
          bottom: 0,right: -10,
          child: AnimatedRotation(turns: turn2, duration: Duration(seconds: 4), child: Text("⚙️",style: TextStyle(fontSize: 80),),)),
      ],
    ),));
  }
}