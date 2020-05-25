import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';
//import 'mainPage.dart';
//import 'package:flutter_ml/main.dart';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.lightGreen,
          ),
          onTap: () => Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: AwesomeLoader(
              loaderType: 4,
              color: Colors.lightGreen,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Loading Nutrients for You',
            style: TextStyle(
              color: Colors.amber,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
