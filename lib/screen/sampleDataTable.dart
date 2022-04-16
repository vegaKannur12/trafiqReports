import 'package:flutter/material.dart';

class SampleDataTable extends StatefulWidget {
  const SampleDataTable({Key? key}) : super(key: key);

  @override
  State<SampleDataTable> createState() => _SampleDataTableState();
}

class _SampleDataTableState extends State<SampleDataTable> {
  final columns = ['First Name', 'Last Name', 'Age'];
  List<String> list = ["dksjd", "kjdksjk", "sjdksjak"];
  List<NameOne> namelist = [
    NameOne(sn: "", name: "asa", address: "fdshifdji", phone: "9061259261"),
    NameOne(sn: "", name: "asa", address: "fdshifdji", phone: "9061259261"),
    NameOne(sn: "", name: "asa", address: "fdshifdji", phone: "9061259261"),
  ]; //list of names, you can generate it using JSON as well

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("dynamic datatable")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: getColumns(columns),
          rows: [
            DataRow(cells: [
              DataCell(Text('f1')),
              DataCell(Text('f2')),
              DataCell(Text('f3')),
            
            ])
          ],
          // rows:list
          //     .map(
          //       (e) => DataRow(cells: [
          //         DataCell(Text(e["id"].toString())),
          //         DataCell(Text(e["barcode"].toString())),
          //         DataCell(Text(e["time"].toString())),
          //         DataCell(TextField()),
          //         // DataCell(Text(e["qty"].toString())),
          //         DataCell(Icon(Icons.delete)),
          //         // DataCell(TextField())
          //       ]),
          //     )
          //     .toList(),
        ),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      // final isAge = column == columns[2];

      return DataColumn(
        label: Text(column),
        // numeric: isAge,
      );
    }).toList();
  }
}

//////////////////////////////////////////////////
class NameOne {
  String? sn;
  String? name;
  String? address;
  String? phone;

  NameOne({this.sn, this.name, this.address, this.phone});
  //constructor

  factory NameOne.fromJSON(Map<String, dynamic> json) {
    return NameOne(
        sn: json["sn"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"]);
  }
}
