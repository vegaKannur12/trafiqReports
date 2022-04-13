import 'package:flutter/material.dart';
import 'package:reports/screen/homePage.dart';
import 'package:reports/screen/level1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Raleway',
        primaryColor: Color.fromARGB(255, 236, 173, 178),
        primarySwatch: Colors.green,
        //  brightness: Brightness.dark,
        //  fontFamily: 'Georgia',

        textTheme:  TextTheme(
          headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          headline6: TextStyle(
            fontSize: 25.0,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: LevelOne(),
    );
  }
}
