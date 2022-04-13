import 'package:flutter/material.dart';
import 'package:reports/screen/homePage.dart';
import 'package:reports/screen/level1.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}