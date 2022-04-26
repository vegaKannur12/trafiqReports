import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports/service/myService.dart';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> reportList = [];
  List<Map<String, dynamic>> specialelements = [];
  List<Map<String, dynamic>> reportCategoryList = [];
  List<Map<String, dynamic>> reportSubCategoryList = [];

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
  // Future getReportApi() async {
  //   try {
  //     Uri url = Uri.parse("$urlgolabl/reports_list.php");
  //     http.Response response = await http.post(
  //       url,
  //       // body: body,
  //     );

  //     var map = jsonDecode(response.body);
  //     //print(map);
  //     for (var item in map) {
  //       reportList.add(item);
  //     }
  //     final jsonData = reportList[0]['special_element2'];
  //     final parsedJson = jsonDecode(jsonData);
  //     //print("parsed json--$parsedJson");
  //     specialelements.clear();
  //     for (var i in parsedJson) {
  //       specialelements.add(i);
  //     }
  //     // print("specialelements.............${specialelements}");
  //     //  print("special_element2.........................${reportList![0]['special_element2']}");
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  /////////////////////////////////////////////////////
  Future getCategoryReport() async {
    try {
      Uri url = Uri.parse("$urlgolabl/report_group_list.php");
      http.Response response = await http.post(
        url,
        // body: body,
      );
      reportCategoryList.clear();
      var map = jsonDecode(response.body);
      //print(map);
      for (var item in map) {
        reportCategoryList.add(item);
      }

      // print("report Category ${reportCategoryList}");
      notifyListeners();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////////////////////////////////////////
  Future getCategoryReportList(String rg_id) async {
    print("rg id---${rg_id}");
    try {
      Uri url = Uri.parse("$urlgolabl/reports_list.php");
      var body = {"rg_id": rg_id};
      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = jsonDecode(response.body);

      reportList.clear();
      print(map);
      for (var item in map) {
        reportList.add(item);
        notifyListeners();
      }
      // print("report list${reportList}");
      final jsonData = reportList[0]['special_element2'];
      final parsedJson = jsonDecode(jsonData);
      //print("parsed json--$parsedJson");
      specialelements.clear();
      for (var i in parsedJson) {
        specialelements.add(i);
      }
      print("specialelements.............${specialelements}");
       print("special_element2.........................${reportList[0]['special_element2']}");

      notifyListeners();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  Future getSubCategoryReportList(String special_field2, String filter_id,
      String fromdate, String tilldate, String old_filter_where_ids) async {
    print(
        "special_field2---${special_field2}  filter_id---${filter_id} fromdate---${fromdate} tilldate---${tilldate} old_filter_where_ids----${old_filter_where_ids}");
    try {
      Uri url = Uri.parse("$urlgolabl/filters_list.php");
      var body = {
        "special_field2": special_field2,
        "filter_id": filter_id,
        "fromdate": fromdate,
        "tilldate": tilldate,
        "old_filter_where_ids": old_filter_where_ids,
      };
      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = jsonDecode(response.body);
      reportSubCategoryList.clear();
      // reportList!.clear();
      // print(map);
      for (var item in map) {
        reportSubCategoryList.add(item);
      }
      print("report list${reportSubCategoryList}");
  

      notifyListeners();
    } catch (e) {
      // print(e);
      return null;
    }
  }
}
