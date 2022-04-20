import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reports/components/customColor.dart';
import 'package:reports/screen/homePage.dart';

class LevelOne extends StatefulWidget {
  const LevelOne({Key? key}) : super(key: key);

  @override
  State<LevelOne> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  List<bool> visible = [];
  List<bool> isExpanded = [];
  Icon actionIcon = Icon(Icons.arrow_downward);
  List<String> listString = ["Main Heading", "level1", "level2"];
  List<String> listShrinkData = ["F1", "F2", "F3"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExpanded = List.generate(listString.length, (index) => false);
    visible = List.generate(listString.length, (index) => true);
  }

  toggle(int i) {
    setState(() {
      isExpanded[i] = !isExpanded[i];
      visible[i] = !visible[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: ListView.builder(
          itemCount: listString.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: P_Settings.color4,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        title: Column(
                          children: [
                            Text(listString[index]),
                            Text('/report page flow'),
                          ],
                        ),
                        trailing: IconButton(
                            icon: isExpanded[index]
                                ? Icon(
                                    Icons.arrow_upward,
                                    // actionIcon.icon,
                                    size: 18,
                                  )
                                : Icon(
                                    Icons.arrow_downward,
                                    // actionIcon.icon,
                                    size: 18,
                                  ),
                            onPressed: () {
                              toggle(index);
                            }),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.004),
                  Visibility(
                    visible: visible[index],
                    child: shrinkedDataTable(context),
                  ),
                  Visibility(
                      visible: isExpanded[index], child: datatable(context)),
                ],
              ),
            );
          }),
      // ),
    );
  }

  Widget shrinkedDataTable(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: size.width * 1.8,
          // height: 90,
          decoration: BoxDecoration(color: P_Settings.datatableColor),
          child: DataTable(
            headingRowHeight: 25,
            dataRowHeight: 25,
            dataRowColor:
                MaterialStateColor.resolveWith((states) => P_Settings.color4),
            columnSpacing: 2,
            border: TableBorder.all(
              color: P_Settings.datatableColor,
            ),
            columns: [
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
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('f1')),
                DataCell(Text('f2')),
                DataCell(Text('f3')),
                DataCell(Text('f4')),
                DataCell(Text('f5')),
                DataCell(Text('f6')),
                DataCell(Text('f7')),
              ])
            ],
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////
  Widget datatable(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _isAscending = true;
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: size.width * 1.8,
          decoration: BoxDecoration(color: P_Settings.datatableColor),
          child: DataTable(
              sortAscending: _isAscending,
              headingRowHeight: 30,
              dataRowHeight: 30,
              dataRowColor:
                  MaterialStateColor.resolveWith((states) => P_Settings.color4),
              border: TableBorder.all(
                color: P_Settings.datatableColor,
              ),
              // headingRowColor: MaterialStateColor.resolveWith(
              //     (states) => P_Settings.datatableColor),
              columns: [
                DataColumn(
                  // onSort: (columnIndex, ascending) {},
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
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('knusha')),
                  DataCell(Text('5644645')),
                  DataCell(Text('3')),
                  DataCell(Text('10')),
                  DataCell(Text('3')),
                  DataCell(Text('10')),
                ]),
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('Anu')),
                  DataCell(Text('5644645')),
                  DataCell(Text('3')),
                  DataCell(Text('19')),
                  DataCell(Text('3')),
                  DataCell(Text('10')),
                ]),
                DataRow(cells: [
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ]),
              ]),
        ),
      ),
    );
  }
}
