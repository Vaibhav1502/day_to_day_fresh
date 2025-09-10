import 'dart:async';
import 'package:flutter/material.dart';
import '../location_screen/location_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
   Timer(Duration(seconds: 2),(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LocationScreen()));
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/images/day_2_day_fresh.png",
            fit: BoxFit.cover,
            height: 500,
            width: 510,
          ),
        ),
      ),
    );
  }
}
