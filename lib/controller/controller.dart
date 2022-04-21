import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports/service/myService.dart';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>>? reportList = [];
  List<Map<String, dynamic>> specialelements = [];

  // getreportResults(String type) {
  //   if (type == "Sales Report") {
  //     reportItems = ["sales1 report", "Sales2 Report"];
  //   }
  //   if (type == "Purchase Report") {
  //     reportItems = [
  //       "Purchase1 report",
  //       "Purchase2 Report",
  //       "Purchase3 Report"
  //     ];
  //   }
  //   notifyListeners();
  // }

//////////////////////////////////////////////////
  Future getReportApi() async {
    try {
      Uri url = Uri.parse("$urlgolabl/reports_list.php");
      http.Response response = await http.post(
        url,
        // body: body,
      );

      var map = jsonDecode(response.body);
      //print(map);
      for (var item in map) {
        reportList!.add(item);
      }
      final jsonData = reportList![0]['special_element2'];                                  
      final parsedJson = jsonDecode(jsonData);
      //print("parsed json--$parsedJson");
      specialelements.clear();
      for (var i in parsedJson) {
        specialelements.add(i);  
      } 
     // print("specialelements.............${specialelements}");
    //  print("special_element2.........................${reportList![0]['special_element2']}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
