import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reports/components/customColor.dart';
import 'package:reports/screen/homePage.dart';

class LevelOne extends StatefulWidget {
  const LevelOne({ Key? key }) : super(key: key);

  @override
  State<LevelOne> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
    bool isExpanded = false;
  bool visible = true;
  Icon actionIcon = Icon(Icons.arrow_downward);
  List<String> listString = ["Main Heading", "level1", "level2"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = true;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Ink(
              decoration: BoxDecoration(
                color: P_Settings.color4,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                onTap: (){
                   Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                },
                title: Column(
                  children: [
                    Text("main heading"),
                    Text('/report page flow'),
                  ],
                ),
                trailing: IconButton(
                    icon: Icon(
                      actionIcon.icon,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                        isExpanded = !isExpanded;
                        if(this.actionIcon.icon==Icons.arrow_downward){
                          print("to up");
                          this.actionIcon=Icon(Icons.arrow_upward);
                        }
                        else if(this.actionIcon.icon==Icons.arrow_upward){
                          print("to down");
                        this.actionIcon=Icon(Icons.arrow_downward);

                        }
                      });
                    }),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Visibility(
              visible: visible,
              child: shrinkedDataTable(),
            ),
            
            Visibility(visible: isExpanded, child: datatable()),
          ],
        ),
      ),
    );
  }
    Widget shrinkedDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 650,
        decoration: BoxDecoration(color: P_Settings.datatableColor),
        child: DataTable(
          
          border: TableBorder.all(
            color: P_Settings.datatableColor,
          ),
          columns: [
            DataColumn(
              label: Text('h1'),
            ),
            DataColumn(
              label: Text('h2'),
            ),
            DataColumn(
              label: Text('h3'),
            ),
            DataColumn(
              label: Text('h4'),
            ),
            DataColumn(
              label: Text('h5'),
            ),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('f1')),
              DataCell(Text('f2')),
              DataCell(Text('f3')),
              DataCell(Text('f4')),
              DataCell(Text('f5')),
            ])
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////
  Widget datatable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 700,
        decoration: BoxDecoration(color: P_Settings.datatableColor),
        child: DataTable(
            border: TableBorder.all(
                // color: P_Settings.datatableColor,
                ),
            // headingRowColor: MaterialStateColor.resolveWith(
            //     (states) => P_Settings.datatableColor),
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
                DataCell(Text('1')),
                DataCell(Text('Anusha')),
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
    );
  }
}