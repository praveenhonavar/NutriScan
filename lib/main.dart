
import 'package:flutter/material.dart';
import 'package:flutter_ml/loader.dart';
import 'package:flutter_ml/mainPage.dart';
import 'package:flutter_ml/read.dart';
import 'package:flutter_ml/splashscreen.dart';


void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        initialRoute: 's',
        routes: {
          'h': (context) => HomePage(),
          'r': (context) => Read(),
          'l':(context) => Load(),
          's':(context)=>Splash(),
        },
      ),
    );
