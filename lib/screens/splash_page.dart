import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacementNamed('/');
      },
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assest/images/logo.png"),
                    fit: BoxFit.cover,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
