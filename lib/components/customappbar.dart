import 'package:flutter/material.dart';
import 'package:reports/components/customColor.dart';

class CustomAppbar extends StatelessWidget {
  late String appbar;
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(P_Settings.title),
     
    );
  }
}