///////////////////////////////////////////
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class SampleDataTable extends StatefulWidget {
  const SampleDataTable({Key? key}) : super(key: key);

  @override
  State<SampleDataTable> createState() => _SampleDataTableState();
}

class _SampleDataTableState extends State<SampleDataTable> {
  final jsondata = [
    {
      "rank": "0",
      // "a": "TLN1_BillNo",
      "b": "TLN1_MRNo",
      "c": "TLN1_PatientName",
      "d": "CRY1_Amt",
      "e": "CRY2_Paid",
      "f": "CRY2_Bal",
      "g": "TLN1_Name",
      "h": "CRY1_Bal",
    },
    {
      "rank": "1",
      // "a": "G202204027",
      "b": "TJAA2",
      "c": "PRATHYEESH MAKRERI KANNUR",
      "d": "472.5",
      "e": "372.5",
      "f": "100",
      "g": "Anu",
      "h": "6859"
    },
    {
      "rank": "1",
      // "a": "G202204026",
      "b": "TJAA2",
      "c": "PRATHYEESH MAKRERI KANNUR",
      "d": "1697.5",
      "e": "1397.5",
      "f": "300",
      "g": "Graha",
      "h": "900"
    }
  ];
  List val = [100, 50, 20, 70, 150];
  List<Map<String, dynamic>> newJson = [];
  final rows = <DataRow>[];
  String? behv;

  List<String>? colName;
  List<String> tableColumn = [];
  List<String> behvr = [];

  Map<String, dynamic> mainHeader = {};
  @override
  void initState() {
    String colsName;
    super.initState();
    print("jsondata[0]---$jsondata[0]");
    mainHeader = jsondata[0];
    print("main header from init state---$mainHeader");
    var list = jsondata[0].values.toList();
    list.removeAt(0);
    for (var item in list) {
      tableColumn.add(item);
    }
    jsondata.removeAt(0);
    for (var item in jsondata) {
      newJson.add(item);
    }
    newJson.forEach((item) => item..remove("rank"));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Dynamic datatable")),
      body: InteractiveViewer(
        boundaryMargin: EdgeInsets.all(8),
        minScale: .025,
        maxScale: 4,
        child: Flexible(
          child: 
          // HorizontalDataTable(
          //   leftHandSideColumnWidth: 100,
          //   rightHandSideColumnWidth: 600,
          //   isFixedHeader: true,
          //   // headerWidgets: _getTitleWidget(),
          // ),
           DataTable(
            horizontalMargin: 0,
            headingRowHeight: 35,
            dataRowHeight: 35,
            dataRowColor:
                MaterialStateColor.resolveWith((states) => Colors.yellow),
            columnSpacing: 0,
            border: TableBorder.all(width: 1, color: Colors.black),
            columns: getColumns(tableColumn,width),
            rows: getRowss(newJson),
          ),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////
  List<DataColumn> getColumns(List<String> columns, double width) {
    print("columns---${columns}");
    String behv;
    String colsName;
    return columns.map((String column) {
      colName = column.split('_');
      colsName = colName![1];
      behv = colName![0];
      behvr.add(behv);
      print('Behave --- $behvr');
      // print(behvr);

      // print(behv[1]);
      print("column---${column}");
      return DataColumn(
        label: Container(
          width: 100,
          // width: behv[3]==1?100:200,
          child: Text(
            colsName,
            // textAlign: TextAlign.center,
            textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
          ),
        ),
      );
    }).toList();
  }

  ////////////////////////////////////////////
  List<DataRow> getRowss(List<Map<String, dynamic>> rows) {
    List<String> newBehavr = [];
    print("rows---$rows");
    return newJson.map((row) {
      return DataRow(
        cells: getCelle(row),
      );
    }).toList();
  }
/////////////////////////////////////////////

  List<DataCell> getCelle(Map<String, dynamic> data) {
    print("data--$data");
    List<DataCell> datacell = [];
    mainHeader.remove('rank');
    print("main header---$mainHeader");

    data.forEach(
      (key, value) {
        mainHeader.forEach(
          (k, val) {
            if (key == k) {
              print("mainHeader[k][3] --${mainHeader[k][3]}");
              datacell.add(
                DataCell(
                  Container(
                    // constraints: BoxConstraints(
                    //   minWidth:
                    //   mainHeader[k][3]==1?50:200
                    // ),
                    // width:100,
                    // width: mainHeader[k][3]==1? mainHeader[k][3]*100 : 200,
                    alignment: mainHeader[k][1] == "L"
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      value,
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
    print(datacell.length);
    return datacell;
  }
}
