import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reports/screen/homePage.dart';

class LevelOne extends StatefulWidget {
  @override
  _LevelOneState createState() {
    return _LevelOneState();
  }
}

class _LevelOneState extends State<LevelOne> {
  bool _expanded = false;
  var _test = "Full Screen";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          color: Colors.green,
          child: ExpansionPanelList(
            animationDuration: Duration(milliseconds: 2000),
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Main Heading',
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: size.height * 0.12,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        // DataTable(columns: [
                        //   DataColumn(
                        //     label: Text('h1'),
                        //   ),
                        //   DataColumn(
                        //     label: Text('h2'),
                        //   ),
                        //   DataColumn(
                        //     label: Text('h3'),
                        //   ),
                        //   DataColumn(
                        //     label: Text('h4'),
                        //   ),
                        //   DataColumn(
                        //     label: Text('h5'),
                        //   ),
                        // ], rows: [
                        //   DataRow(cells: [
                        //     DataCell(Text('f1')),
                        //     DataCell(Text('f2')),
                        //     DataCell(Text('f3')),
                        //     DataCell(Text('f4')),
                        //     DataCell(Text('f5')),
                        //   ])
                        // ]),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  );
                },
                isExpanded: _expanded,
                canTapOnHeader: false,
                body: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(columns: [
                    DataColumn(
                      label: Text('ID'),
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Code'),
                    ),
                    DataColumn(
                      label: Text('Quantity'),
                    ),
                    DataColumn(
                      label: Text('Amount'),
                    ),
                    DataColumn(
                      label: Text('Quantity'),
                    ),
                    DataColumn(
                      label: Text('Amount'),
                    ),
                  ], rows: [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Arshik')),
                      DataCell(Text('5644645')),
                      DataCell(Text('3')),
                      DataCell(Text('265')),
                      DataCell(Text('3')),
                      DataCell(Text('265')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('Arshik')),
                      DataCell(Text('5644645')),
                      DataCell(Text('3')),
                      DataCell(Text('265')),
                      DataCell(Text('3')),
                      DataCell(Text('265')),
                    ]),
                  ]),
                ),
              ),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _expanded = !_expanded;
              setState(() {});
            },
          ),
        ),
      ]),
    );
  }
}

/////////// while using api connection add multiple row dynamically/////////////////
// your array data
// var datas = [...]

// // add new data to it
// setState((){
//   datas.add(...);
// });

// // use them for your DataRow
// DataTable(
//   row: datas.map((data){
//     return DataRow(
//        cells:[
//          // your cells
//          DataCell(Text(data.fieldValue))
//        ]
//     );
//   }).toList()
// )