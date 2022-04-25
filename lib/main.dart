import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports/components/customColor.dart';
import 'package:reports/controller/controller.dart';
import 'package:reports/drawersample.dart';
import 'package:reports/screen/call.dart';
import 'package:reports/screen/datatable.dart';
import 'package:reports/screen/datatable1.dart';
import 'package:reports/screen/homePage.dart';
import 'package:reports/screen/horizontal_datatablr.dart';
import 'package:reports/screen/level1.dart';
import 'package:reports/screen/level1Sample.dart';
import 'package:reports/screen/level2.dart';
import 'package:reports/screen/refer.dart';
import 'package:reports/screen/sampleDataTable.dart';
import 'package:reports/screen/splashscreen.dart';
import 'package:reports/screen/table.dart';
import 'package:reports/screen/zoomtest.dart';

import 'screen/dataTabletest.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>Controller())
      ],
    child:MyApp(),)
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       visualDensity: VisualDensity.adaptivePlatformDensity,

        fontFamily: 'Raleway',
        primaryColor: P_Settings.color1,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ),
        scaffoldBackgroundColor: P_Settings.color2,
        //  brightness: Brightness.dark,
        //  fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          headline6: TextStyle(
            fontSize: 25.0,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
