import 'dart:async';

import 'package:flutter/material.dart';
import 'package:awesome_loader/awesome_loader.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.popAndPushNamed(context, 'h'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'NutriScan',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AwesomeLoader(
                    loaderType: 4,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   'Loading Details',
                  //   style: TextStyle(
                  //     fontSize: 15,
                  //     color: Colors.teal,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
