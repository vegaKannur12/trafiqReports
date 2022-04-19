import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Controller extends ChangeNotifier{
  List<String> reportItems = ["level 1", "level 2", "level3"];

  List<String> drawerItems = ["Sales Report", "Purchase Report", "Sales Report"];

  getreportResults(String type){
    if(type=="Sales Report"){
    reportItems=["sales1 report","Sales2 Report"];

    }
    if(type=="Purchase Report"){
      reportItems=["Purchase1 report","Purchase2 Report","Purchase3 Report"];
    }
    notifyListeners();
  }
//////////////////////////////////////////////////
  getReportApi()async{
    try {
          
        } catch (e) {
          print(e);
          return null;
        }
  }
}