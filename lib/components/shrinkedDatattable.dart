import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reports/components/customColor.dart';

class ShrinkedDatatable extends StatefulWidget {
  // Map<String, dynamic> map;
  var decodd;
  ShrinkedDatatable({required this.decodd});

  @override
  State<ShrinkedDatatable> createState() => _ShrinkedDatatableState();
}

class _ShrinkedDatatableState extends State<ShrinkedDatatable> {
  List<String> tableColumn = [];
  Map<String, dynamic> valueMap = {};
  List<String>? colName;
  List<String>? rowName;
  var mapTabledata;
  // var jsondata;

  List<Map<String, dynamic>> newMp = [];
  String? behv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.decodd != null) {
      mapTabledata = json.decode(widget.decodd);
      // print("json data----${jsondata}");
    } else {
      print("null");
    }
    // Map<String, dynamic> mapTabledata = widget.map;
    // print("mapTabledata---${mapTabledata}");
    mapTabledata.remove("acc_rowid");
    mapTabledata.remove("sg");
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 0,
        headingRowHeight: 35,
        dataRowHeight: 35,
        decoration: BoxDecoration(color: P_Settings.datatableColor),
        border: TableBorder.all(
          color: P_Settings.datatableColor,
        ),
        dataRowColor:
            MaterialStateColor.resolveWith((states) => P_Settings.color4),
        columns: getColumns(tableColumn),
        rows: getRowss(newMp),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    String behv;
    String colsName;
    return columns.map((String column) {
      // final isAge = column == columns[2];
      colName = column.split('_');
      colsName = colName![1];
      behv = colName![0];
      print("column---${column}");
      return DataColumn(
        tooltip: colsName,
        label: Container(
          // width: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              colsName,
              style: TextStyle(fontSize: 12),
              textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
            ),
          ),
        ),
      );
    }).toList();
  }

  ////////////////////////////////////////////////////////////
  List<DataRow> getRowss(List<Map<String, dynamic>> row) {
    return newMp.map((row) {
      return DataRow(
        cells: getCelle(row),
      );
    }).toList();
  }

  ///////////////////////////////////////////////////////////
  List<DataCell> getCelle(Map<String, dynamic> data) {
    String behv;
    String colsName;
    print("data--$data");
    List<DataCell> datacell = [];
    for (var i = 0; i < tableColumn.length; i++) {
      data.forEach((key, value) {
        if (tableColumn[i] == key) {
          rowName = tableColumn[i].split('_');
          colsName = rowName![1];
          behv = rowName![0];
          // print("column---${tableColumn[i]}");
          datacell.add(
            DataCell(
              Container(
                // width: 50,
                alignment: behv[1] == "L"
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value.toString(),
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ),
          );
        }
      });
    }
    print(datacell.length);
    return datacell;
  }
}
