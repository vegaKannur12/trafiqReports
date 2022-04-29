import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports/service/myService.dart';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  bool? isLoading;
  bool backButtnClicked=false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> reportList = [];
  List<Map<String, dynamic>> specialelements = [];
  List<Map<String, dynamic>> reportCategoryList = [];
  List<Map<String, dynamic>> reportSubCategoryList = [];
  List<bool> visible = [];
  List<bool> isExpanded = [];
  String? fromDate;
  String? todate;
  String? searchkey;
  List<Map<String, dynamic>> newList = [];
  bool isSearch = false;
   
  String? special;
  List<String> tableColumn = [];
  Map<String, dynamic> valueMap = {};
  List<String>? colName;
  int i = 0;
  List<String>? rowName;
  Map<String, dynamic> mapTabledata = {};
  List<Map<String, dynamic>> newMp = [];
  List<DataCell> datacell = [];
  List<Map<String, dynamic>> resultCopy = [];
 
  /////////////////////////////////////////////////////
  getCategoryReport() async {
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
  getCategoryReportList(String rg_id) async {
    print("rg id---${rg_id}");
    // resultCopy.clear();
    try {
      Uri url = Uri.parse("$urlgolabl/reports_list.php");
      var body = {"rg_id": rg_id};
      http.Response response = await http.post(
        url,
        body: body,
      );
      var map = jsonDecode(response.body);

      reportList.clear();
      // print(map);
      for (var item in map) {
        reportList.add(item);
        // notifyListeners();
      }
      // print("report list${reportList}");
      final jsonData = reportList[0]['special_element2'];
      // print("${reportList[3]}");
      final parsedJson = jsonDecode(jsonData);
      print("parsed json--$parsedJson");
      specialelements.clear();
      for (var i in parsedJson) {
        specialelements.add(i);
      }
      print("report list---${reportList}");
      // print("reportList[4]['report_elements']---${reportList[3]}");

      print("specialelements.............${specialelements}");
      //  print("special_element2.........................${reportList[0]['special_element2']}");
      // resultCopy=reportList;
      notifyListeners();
    } catch (e) {
      // print(e);
      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////////////////
  Future getSubCategoryReportList(String special_field2, String filter_id,
      String fromdate, String tilldate, String old_filter_where_ids) async {
      // resultCopy.clear();
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
      isLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );

      isLoading = false;
      notifyListeners();
      var map = jsonDecode(response.body);
      reportSubCategoryList.clear();
      // reportList!.clear();
      // print(map);
      for (var item in map) {
        reportSubCategoryList.add(item);
      }
      var length = reportSubCategoryList.length;
      isExpanded = List.generate(length, (index) => false);
      visible = List.generate(length, (index) => true);
      print("isExpanded---$isExpanded");
      print("visible---$visible");
      print("report list ---- ${reportSubCategoryList}");  

      // resultCopy=reportSubCategoryList;

      notifyListeners();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  ////////////////////////////////////////////////////////clear///
  clearSubCategoryList() {
    reportSubCategoryList.clear();
    // notifyListeners();///
  }

  navigatorClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  toggleData(int i) {
    isExpanded[i] = !isExpanded[i];
    visible[i] = !visible[i];
    notifyListeners();
  }

  setDate(String fromD, String toD) {
    fromDate = fromD;
    todate = toD;
    notifyListeners();
  }

  setSearchKey(String searchKey) {
    print("searchKey----${searchKey}");

    searchkey = searchkey;
    notifyListeners();
  }

  setisSearch(bool isSearch) {
    isSearch = isSearch;
    print("isSerarch Controller----${isSearch}");
    notifyListeners();
  }

  searchProcess(String level) {
    print("isSearch process----${isSearch}");
    print("searchKey process----${searchkey}");

    if (level == "level1" && isSearch == true) {
      newList = reportSubCategoryList
          .where((cat) =>
              cat["sg"].toUpperCase().contains(searchkey!.toUpperCase()))
          .toList();
      print("nw list---$newList");
      notifyListeners();
    }
    if (level == "level2" && isSearch == true) {
      newList = reportSubCategoryList
          .where((cat) =>
              cat["cat_name"].toUpperCase().contains(searchkey!.toUpperCase()))
          .toList();
      print("nw list---$newList");
      notifyListeners();
    }
    if (level == "level3" && isSearch == true) {
      newList = reportSubCategoryList
          .where((cat) => cat["batch_name"]
              .toUpperCase()
              .contains(searchkey!.toUpperCase()))
          .toList();
      print("nw list---$newList");
      notifyListeners();
    }
  }

  setSpecialField(String specField) {
    special = specField;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////

  datatableCreation(var jsonData, String level) {
    mapTabledata.clear();
    newMp.clear();
    tableColumn.clear();
    valueMap.clear();
    if (jsonData != null) {
      mapTabledata = json.decode(jsonData);
      // print("json data----${jsondata}");
    } else {
      print("null");
    }
    if (level == "level1") {
      mapTabledata.remove("sg");
      mapTabledata.remove("acc_rowid");
    } else if (level == "level2") {
      mapTabledata.remove("cat_id");
      mapTabledata.remove("cat_name");
    } else if (level == "level3") {
      mapTabledata.remove("batch_code");
      mapTabledata.remove("batch_name");
    }

    print("map after deletion${mapTabledata} ");
    print("mapTabledata---${mapTabledata}");
    mapTabledata.forEach((key, value) {
      tableColumn.add(key);
      valueMap[key] = value;
    });
    newMp.add(valueMap);
    print("tableColumn---${tableColumn}");
    print("valueMap---${valueMap}");
    print("newMp---${newMp}");
  }

//  List<DataCell> createDatacell(String value,String behv) {
//     // datacell.clear();
//     datacell.add(
//       DataCell(
//         Container(
//           width: 50,
//           alignment:
//               behv == "L" ? Alignment.centerLeft : Alignment.centerRight,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               value.toString(),
//               style: TextStyle(fontSize: 11),
//             ),
//           ),
//         ),
//       ),
//     );
//     return datacell;
//   }
}
