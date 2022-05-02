import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports/service/myService.dart';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  String? old_filter_where_ids;
  // String? filter_id;
  String? tilName;
  bool? isLoading;
  bool istabLoading=false;

  bool backButtnClicked = false;
  String urlgolabl = Globaldata.apiglobal;
  List<Map<String, dynamic>> reportList = [];
  List<Map<String, dynamic>> specialelements = [];
  List<Map<String, dynamic>> reportCategoryList = [];
  List<Map<String, dynamic>> level1reportList = [];
  List<Map<String, dynamic>> level2reportList = [];
  List<Map<String, dynamic>> level3reportList = [];
  List<Map<String, dynamic>> level4reportList = [];

  List<bool> l1visible = [];
  List<bool> l1isExpanded = [];
  List<bool> l2visible = [];
  List<bool> l2isExpanded = [];
  List<bool> l3visible = [];
  List<bool> l3isExpanded = [];
  List<bool> l4visible = [];
  List<bool> l4isExpanded = [];
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
  List<Map<String, dynamic>> tableJson = [];
  List<Map> mapJsondata = [];
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
      print("report list${reportList}");
      final jsonData = reportList[0]['special_element2'];

      // final jsonData ='[[{"label":"QTY","value":"1"},{"label":"BATCH COST","value":"B.batch_cost"}],[{"label":"QTY","value":"1"},{"label":"BATCH COST","value":"B.batch_cost"}]]';
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
  Future getSubCategoryReportList(
      String special_field,
      String filter_id,
      String fromdate,
      String tilldate,
      String old_filter_where_ids,
      String level) async {
    // resultCopy.clear();
    print(
        "special_field2---${special_field}  filter_id---${filter_id} fromdate---${fromdate} tilldate---${tilldate} old_filter_where_ids----${old_filter_where_ids}");
    try {
      Uri url = Uri.parse("$urlgolabl/filters_list.php");
      var body = {
        "special_field": special_field,
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
      if (level == "level1") {
        var map1 = jsonDecode(response.body);

        level1reportList.clear();
        for (var item in map1) {
          level1reportList.add(item);
        }
        var length = level1reportList.length;
        l1isExpanded = List.generate(length, (index) => false);
        l1visible = List.generate(length, (index) => true);
        // print("isExpanded---$isExpanded");
        // print("visible---$visible");
        // print("report list ---- ${level1reportList}");
      }
      if (level == "level2") {
        var map2 = jsonDecode(response.body);
        print("dfbjdjzfn${level1reportList.length}");
        level2reportList.clear();
        for (var item in map2) {
          level2reportList.add(item);
        }
        var length = level2reportList.length;
        l2isExpanded = List.generate(length, (index) => false);
        l2visible = List.generate(length, (index) => true);
        // print("isExpanded---$isExpanded");
        // print("visible---$visible");
        // print("report list ---- ${level2reportList}");
      }
      if (level == "level3") {
        var map3 = jsonDecode(response.body);

        level3reportList.clear();
        for (var item in map3) {
          level3reportList.add(item);
        }
        var length = level3reportList.length;
        l3isExpanded = List.generate(length, (index) => false);
        l3visible = List.generate(length, (index) => true);
        // print("isExpanded---$isExpanded");
        // print("visible---$visible");
        print("report list ---- ${level3reportList}");
      }
      if (level == "level4") {
        var map4 = jsonDecode(response.body);

        level4reportList.clear();
        for (var item in map4) {
          level4reportList.add(item);
        }
        var length = level4reportList.length;
        l4isExpanded = List.generate(length, (index) => false);
        l4visible = List.generate(length, (index) => true);
        // print("isExpanded---$isExpanded");
        // print("visible---$visible");
        print("report list ---- ${level4reportList}");
      }

      // resultCopy=reportSubCategoryList;

      notifyListeners();
    } catch (e) {
      // print(e);
      return null;
    }
  }

  ////////////////////////////////////////////////////////clear///
  Future getExpansionJson(
      String special_field,
      String filter_id,
      String fromdate,
      String tilldate,
      String old_filter_where_ids,
      String special_field2,
      String level) async {
    try {
      print(
          "special_field---${special_field} special_field2---${special_field2} filter_id---${filter_id} fromdate---${fromdate} tilldate---${tilldate} old_filter_where_ids----${old_filter_where_ids}");
      Uri url = Uri.parse("$urlgolabl/filter_tile_expansion.php");
      var body = {
        "special_field": special_field,
        "filter_id": filter_id,
        "fromdate": fromdate,
        "tilldate": tilldate,
        "old_filter_where_ids": old_filter_where_ids,
        "special_field2": special_field2,
      };
      istabLoading = true;
      notifyListeners();
      http.Response response = await http.post(
        url,
        body: body,
      );
      tableJson.clear();
      istabLoading = false;
      notifyListeners();

      var map = jsonDecode(response.body);
      for (var item in map) {
        tableJson.add(item);
      }
      // print("tableJson-----${tableJson}");
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  /////////////////////////////////////////////////////////////
  clearlevelsreportList(String level) {
    if (level == "level1") {
      level1reportList.clear();
    }
    if (level == "level2") {
      level2reportList.clear();
      print("level2 aftr clear---${level2reportList.length}");
    }
    if (level == "level3") {
      level3reportList.clear();
    }
    if (level == "level4") {
      level4reportList.clear();
    }
    notifyListeners();
    // reportSubCategoryList.clear();
    // notifyListeners();///
  }

  navigatorClose(BuildContext context) {
    Navigator.of(context).pop();
  }

  toggleData(int i, String level) {
    if (level == "level1") {
      l1isExpanded[i] = !l1isExpanded[i];
      l1visible[i] = !l1visible[i];
    }
    if (level == "level2") {
      l2isExpanded[i] = !l2isExpanded[i];
      l2visible[i] = !l2visible[i];
    }
    if (level == "level3") {
      l3isExpanded[i] = !l3isExpanded[i];
      l3visible[i] = !l3visible[i];
    }
    if (level == "level4") {
      l4isExpanded[i] = !l4isExpanded[i];
      l4visible[i] = !l4visible[i];
    }

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
      newList = level1reportList
          .where((cat) =>
              cat["sg"].toUpperCase().contains(searchkey!.toUpperCase()))
          .toList();
      print("nw list---$newList");
      notifyListeners();
    }
    if (level == "level2" && isSearch == true) {
      newList = level2reportList
          .where((cat) =>
              cat["cat_name"].toUpperCase().contains(searchkey!.toUpperCase()))
          .toList();
      print("nw list---$newList");
      notifyListeners();
    }
    if (level == "level3" && isSearch == true) {
      newList = level3reportList
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

  datatableCreation(var jsonData, String level, String type) {
    mapTabledata.clear();
    newMp.clear();
    tableColumn.clear();
    valueMap.clear();
    if (jsonData != null) {
      mapTabledata = json.decode(jsonData);
      // print("json data----${jsondata}");
    } else {
      // print("null");
    }
    if (type == "shrinked") {
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
    }

    // print("map after deletion${mapTabledata} ");
    // print("mapTabledata---${mapTabledata}");
    mapTabledata.forEach((key, value) {
      tableColumn.add(key);
      valueMap[key] = value;
    });
    newMp.add(valueMap);
    // print("tableColumn---${tableColumn}");
    // print("valueMap---${valueMap}");
    // print("newMp---${newMp}");
  }

  /////////////////////////////////////////////
  expandedtableCreation(
    var jsonData,
  ) {
    mapJsondata.clear();
    newMp.clear();
    tableColumn.clear();
    valueMap.clear();
    if (jsonData != null) {
      // mapJsondata = json.decode(jsonData);
      print("json data----${jsonData}");
    }
  }
}
