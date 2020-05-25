import 'dart:convert';
import 'dart:io';
import 'package:flutter_ml/loader.dart';
import 'package:flutter_ml/nutridetails.dart';
import 'package:flutter_ml/read.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int c = 0;

  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      c = prefs.getInt('counter') ?? 0;
      print('cccccccccc$c');
    });
  }

  remove(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.remove('counter');
      loadCounter();
    });
  }

  @override
  void initState() {
    super.initState();

    loadCounter();
  }

  var url =
      'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=DEMO_KEY&query=';

  File pickedImage;

  bool img = false;

  bool txt = false;
  bool isLoaded = false;
  VisionText vt;
  TextBlock block;
  int currentIndex = 1;
  Foods f;

  pickImage() async {
    var temp = await ImagePicker.pickImage(source: ImageSource.camera);

    temp == null
        ? pickedImage =
            File('android\app\src\main\res\mipmap-mdpi\ic_launcher.png')
        : setState(
            () {
              try {
                pickedImage = temp;
                img = true;
                readText();
              } catch (e) {
                print(e);
              }
            },
          );
  }

  chooseImage() async {
    var temp = await ImagePicker.pickImage(source: ImageSource.gallery);

    temp == null
        ? pickedImage =
            File('android\app\src\main\res\mipmap-mdpi\ic_launcher.png')
        : setState(
            () {
              try {
                pickedImage = temp;
                //f.foodimg = pickedImage;
                print('lllolkl');
                img = true;
                readText();
              } catch (e) {
                img = false;
                print(e);
              }
              // temp == null ? : pickedImage = temp;
              // img = true;
            },
          );
  }

  readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText readText = await textRecognizer.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      print(block.text);
      setState(() {
        txt = true;
        vt = readText;
      });
    }
  }

  getNutri(VisionText data) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Load(),
      ),
    );

    img = false;

    var res;

    res = await get(url + data.text);
    var detail = jsonDecode(res.body);

    print('ddddddd' + detail.toString());

    Nutridetails nutri = Nutridetails.fromJson(detail);

    f = nutri.foods[0];
    print('getttttttttttt');
    print(res);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Read(),
        settings: RouteSettings(arguments: f),
      ),
    );

    int len = f.foodNutrients.length;
    if (len == 0) {
      print('ggggg');
    } else {
      for (int i = 0; i < len; i++) {
        print('innnnnn');
        String k = f.foodNutrients[i].nutrientName;
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
      Foods f = nutri.foods[0];

      pobj = f.foodNutrients[protein];
      cobj = f.foodNutrients[carbo];
      eobj = f.foodNutrients[energy];

      print(pobj.nutrientName);

      isLoaded = true;
    });
  }

  chooseScreen() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Choose from gallery',
                    ),
                    onTap: chooseImage,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    child: Text(
                      'Open Camera',
                    ),
                    onTap: pickImage,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // var counter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      drawerScrimColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Home'),
              leading: Icon(
                Icons.home,
              ),
              onTap: () => Navigator.of(context).pop(),
            ),
            Divider(),
            ListTile(
              title: Text('Reset Today\'s Calories'),
              leading: Icon(
                Icons.restore,
              ),
              onTap: () => remove(context),
            ),
            Divider(),
            ListTile(
              title: Text('About'),
              leading: Icon(
                Icons.info_outline,
              ),
              //onTap: () => remove(context),
            ),
            Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
            child: Icon(
              Icons.more_vert,
              color: Colors.green,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Icon(
            Icons.menu,
            color: Colors.green,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white12,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'NutriScan',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          img
              ? Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(pickedImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    GestureDetector(
                      child: FlatButton(
                        onPressed: null,
                        //onPressed: ()=>CircularProgressIndicator(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 45,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Tap to Proceed',
                            ),
                          ],
                        ),
                      ),
                      onTap: () => getNutri(vt),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Center(
                      child: CircularStepProgressIndicator(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.flash_on,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${2500 - c}',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'REMAINING',
                              style: TextStyle(
                                color: Colors.grey,
                                //fontSize: 20
                              ),
                            ),
                          ],
                        ),
                        totalSteps: 2500,
                        currentStep: c,
                        stepSize: 10,
                        selectedColor: Colors.greenAccent,
                        unselectedColor: Colors.grey[200],
                        padding: 0,
                        width: 200,
                        height: 200,
                        selectedStepSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Text(
                            '$c',
                            style: TextStyle(
                                //color: Colors.grey,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'CONSUMED',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,

                                //fontSize: 20
                              ),
                            ),
                          ),
                        ]),
                        Column(
                          children: <Widget>[
                            Text(
                              '2500',
                              style: TextStyle(
                                  //color: Colors.grey,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'REQURIED',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                //fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            title: Text(
              'Search',
            ),
            icon: Icon(
              Icons.search,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            title: Text(
              'Scan Food',
            ),
            icon: GestureDetector(
              onTap: () => chooseScreen(),
              child: Icon(
                Icons.camera_alt,
                size: 40,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            title: Text(
              'Account',
            ),
            icon: InkWell(
              child: Icon(
                Icons.person,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
