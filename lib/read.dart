//import 'dart:convert';
//import 'dart:js';

//import 'package:flutter_ml/mainPage.dart';
//import 'package:flutter_ml/main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

//import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:flutter_ml/nutridetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mainPage.dart';

class Read extends StatefulWidget {
  @override
  _ReadState createState() => _ReadState();
}

FoodNutrients pobj;
FoodNutrients cobj;
FoodNutrients eobj;
FoodNutrients fatobj;

int protein;
int carbo;
double fats;
double sugar;
int energy;
String desc;

class _ReadState extends State<Read> {
  bool isLoaded = true;

  HomePage homePage = new HomePage();
  int counter = 0;

  var url =
      'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=DEMO_KEY&query=';

  @override
  void initState() {
    super.initState();
    loadCounter();
    //getNutri(data);
  }

  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        counter = prefs.getInt('counter') ?? 0;
      },
    );
  }

  addCounter(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      counter = (prefs.getInt('counter') ?? 0) + int.parse(eobj.nutrientNumber);
      prefs.setInt('counter', counter);
    });

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
        settings: RouteSettings(arguments: counter),
      ),
    );
  }

  remove(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.remove('counter');
      loadCounter();
    });

    //Navigator.pop(context);
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
        settings: RouteSettings(arguments: counter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Foods f = ModalRoute.of(context).settings.arguments;
    int len = f.foodNutrients.length;

    if (len == 0) {
      print('ggggg');
    } else {
      for (int i = 0; i < len; i++) {
        print('innnnnn');
        String k = f.foodNutrients[i].nutrientName;

        if (int.parse(f.foodNutrients[i].nutrientNumber) == 204) {
          fats = f.foodNutrients[i].value;
        }

        if (int.parse(f.foodNutrients[i].nutrientNumber) == 269) {
          sugar = f.foodNutrients[i].value;
        }

        //print(k);

        if (k == 'Protein') {
          print(i);
          protein = i;
        } else if (k == "Carbohydrate, by difference") {
          print(i);
          carbo = i;
        } else if (k == "Carbohydrate, by difference") {
          print(i);
          carbo = i;
        } else if (k == 'Energy') {
          print(i);
          energy = i;
        } else {
          continue;
        }

        //pobj = f.foodNutrients[protein];
        // print(fobj.nutrientName);

      }
    }

    //FoodNutrients fobj = new FoodNutrients.fromJson(f.toJson());

    //print(fobj.nutrientId);

    setState(() {
      pobj = f.foodNutrients[protein];
      cobj = f.foodNutrients[carbo];
      eobj = f.foodNutrients[energy];
      desc = f.description;
      fats = fats;
      sugar = sugar;
      isLoaded = true;
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isLoaded
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 38.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Your food item is \n $desc \n having following nutrients',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          // Text(
                          //     'Protiens:${pobj.nutrientNumber} ${pobj.unitName}'),
                          // Text(
                          //     'Carbhohydrates:${cobj.nutrientNumber} ${cobj.unitName}'),
                          // Text(
                          //     'Energy:${eobj.nutrientNumber}  ${eobj.unitName}'),
                          // SizedBox(
                          //   height: 50,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CircularStepProgressIndicator(
                              
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'CAL',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text(
                                      '${eobj.value}',
                                    ),
                                    //  SizedBox(
                                    //   height: 1,
                                    // ),
                                    Text(
                                      'kcal',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                totalSteps: 500,
                                currentStep: int.parse(eobj.nutrientNumber),
                                stepSize: 10,
                                selectedColor:Color(
                                0xFFFAD02C
                              ),
                                unselectedColor: Colors.grey[200],
                                padding: 0,
                                width: 100,
                                height: 100,
                                selectedStepSize: 15,
                              ),
                              CircularStepProgressIndicator(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'PROT',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text(
                                      '${pobj.value}',
                                    ),

                                    //  SizedBox(
                                    //   height: 1,
                                    // ),

                                    Text(
                                      'grams',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                totalSteps: 300,
                                currentStep: int.parse(eobj.nutrientNumber),
                                stepSize: 10,
                                selectedColor: Color(
                                  0xFF67E1E8
                                ),
                                unselectedColor: Colors.grey[200],
                                padding: 0,
                                width: 100,
                                height: 100,
                                selectedStepSize: 15,
                              ),
                              CircularStepProgressIndicator(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'CARBS',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text(
                                      '${cobj.value}',
                                    ),
                                    //  SizedBox(
                                    //   height: 1,
                                    // ),
                                    Text(
                                      'grams',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                totalSteps: 500,
                                currentStep: int.parse(cobj.nutrientNumber),
                                stepSize: 10,
                                selectedColor: Color(
                                  0xFFE151AF
                                ),
                                unselectedColor: Colors.grey[200],
                                padding: 0,
                                width: 100,
                                height: 100,
                                selectedStepSize: 15,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CircularStepProgressIndicator(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Sugar',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text(
                                      '$sugar',
                                    ),
                                    //  SizedBox(
                                    //   height: 1,
                                    // ),
                                    Text(
                                      'grams',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                totalSteps: 500,
                                currentStep: int.parse(cobj.nutrientNumber),
                                stepSize: 10,
                                selectedColor: Color(
                                  0xFFABEA7C
                                ),
                                unselectedColor: Colors.grey[200],
                                padding: 0,
                                width: 100,
                                height: 100,
                                selectedStepSize: 15,
                              ),
                              CircularStepProgressIndicator(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'FAT',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    Text(
                                      '$fats',
                                    ),
                                    //  SizedBox(
                                    //   height: 1,
                                    // ),
                                    Text(
                                      'grams',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                totalSteps: 500,
                                currentStep: int.parse(cobj.nutrientNumber),
                                stepSize: 10,
                                selectedColor: Color(
                                  0xFF5428AB
                                ),
                                unselectedColor: Colors.grey[200],
                                padding: 0,
                                width: 100,
                                height: 100,
                                selectedStepSize: 15,
                              ),
                            ],
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: <Widget>[
                          //       Column(
                          //         //crossAxisAlignment: CrossAxisAlignment.end,
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: <Widget>[
                          //           Padding(
                          //             padding: const EdgeInsets.only(top: 28.0),
                          //             child: Text(
                          //               'Do you want to add it to \n your daily calorie intake?',
                          //               textAlign: TextAlign.justify,
                          //               style: TextStyle(),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 250,
                          // ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Do you want to add it to \n your daily calorie intake?',
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FloatingActionButton(
                                heroTag: 'add',
                                backgroundColor: Colors.green,
                                onPressed: () => addCounter(context),
                                child: Icon(
                                  Icons.done,
                                ),
                              ),
                              FloatingActionButton(
                                heroTag: 'remove',
                                backgroundColor: Colors.red,
                                onPressed: () =>
                                    Navigator.popAndPushNamed(context, 'h'),
                                child: Icon(
                                  Icons.clear,
                                  semanticLabel: 'Dont Add',
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : CircularProgressIndicator(),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
