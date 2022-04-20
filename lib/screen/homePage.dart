// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:reports/components/customColor.dart';
import 'package:reports/components/customDatePicker.dart';
import 'package:reports/components/customappbar.dart';
import 'package:reports/controller/controller.dart';
import 'package:reports/screen/level1Sample.dart';
import 'package:reports/screen/level2.dart';

class HomePage extends StatefulWidget {
  // final _draweItems = [
  //   new DrawerItem("sales report ", Icons.report),
  //   new DrawerItem("purchase report", Icons.report),
  //   new DrawerItem("sales report", Icons.report)
  // ];
  // HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  DateTime currentDate = DateTime.now();
  String? formattedDate;
  String? crntDateFormat;
  String searchkey = "";
  bool isSearch = false;
  bool visible = true;
  // int _selectedIndex = 0;
  bool isSelected = true;
  bool buttonClicked = false;
  _onSelectItem(int index, String reportType) {
    // print("report  ---${reportType}");
    _selectedIndex.value = index;
    //  print(_selectedIndex.value);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    Provider.of<Controller>(context, listen: false).getReportApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////
    List<Widget> drawerOpts = [];
    String? type;
    String? type1;
    String? type2;
    //// date picker ////////////////
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: currentDate.subtract(Duration(days: 0)),
          lastDate: DateTime(2023));
      if (pickedDate != null) {
        setState(() {
          currentDate = pickedDate;
        });
      } else {
        print("please select date");
      }
      formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
    }

    // for (var i = 0;
    //      i < Provider.of<Controller>(context, listen: false).getReportApi().length;
    //     i++) {
    //   // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
    //   drawerOpts.add(Consumer<Controller>(builder: (context, value, child) {
    //     return ListTile(
    //         // leading: new Icon(d.icon),
    //         // title: new Text(
    //         //   value.ge[i],
    //         //   style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
    //         // ),
    //         selected: i == _selectedIndex.value,
    //         onTap: () {
    //           // _onSelectItem(i, value.drawerItems[i]);
    //           // Navigator.push(
    //           //                 context,
    //           //                 MaterialPageRoute(builder: (context) => Level1Sample()),
    //           //               );
    //         });
    //   }));
    // }
    /////////////////////////////////////////////////////////////////////
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // title: Text(widget._draweItems[_selectedIndex].title),
        title: Text("Reports"),
      ),
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: ValueListenableBuilder(
      //       valueListenable: _selectedIndex,
      //       builder: (BuildContext context, int selectedValue, Widget? child){
      //         return CustomAppbar(
      //             title:  Provider.of<Controller>(context, listen: false)
      //                 .getreportResults(reportItems));
      //       }),
      // ),

      ///////////////////////////////////////////////////////////////////
      drawer: Drawer(
        child: new Column(
          children: <Widget>[
            Container(
              height: size.height * 0.2,
              color: P_Settings.color3,
            ),
            Column(children: drawerOpts)
          ],
        ),
      ),
      body: Column(
        children: [
          // Text(widget._draweItems[_selectedIndex].title),
          buttonClicked
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ConstrainedBox(
                        constraints: new BoxConstraints(
                          minHeight: 20.0,
                          minWidth: 80.0,
                        ),
                        child: SizedBox.shrink(
                          child: InkWell(
                            onTap: (() {
                              // print("Icon button --${buttonClicked}");
                              setState(() {
                                buttonClicked = false;
                              });
                            }),
                            child: Icon(Icons.calendar_month),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Consumer<Controller>(builder: (context, value, child) {
                  // type = value.reportList![4]["report_elements"].toString();
                  if (value.reportList != null &&
                      value.reportList!.isNotEmpty) {
                    type = value.reportList![4]["report_elements"].toString();
                    // print("type....${type}");
                    List<String> parts = type!.split(',');
                    type1 = parts[0].trim(); // prefix: "date"
                    type2 = parts[1].trim(); // prefix: "date"
                    //  print("type1....${type1}");
                    //  print("type2....${type2}");
                  }
                  {
                    return Container(
                      color: Colors.yellow,
                      // height: size.height * 0.27,
                      child: Container(
                        height: size.height * 0.1,
                        color: P_Settings.dateviewColor,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Container(
                                    width: size.width * 0.2,
                                    height: size.height * 0.09,
                                    child: Center(
                                      child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        // mainAxisAlignment:MainAxisAlignment.center ,
                                        children: [
                                          // IconButton(
                                          //   onPressed: () {
                                          //     _selectDate(context);
                                          //   },
                                          //   icon: Icon(Icons.calendar_month),
                                          // ),

                                          // visible == true
                                          //     ? Container(
                                          //         child: formattedDate == null
                                          //             ? Text(crntDateFormat
                                          //                 .toString())
                                          //             : Text(formattedDate
                                          //                 .toString()))
                                          //     : Container(
                                          //         child: formattedDate == null
                                          //             ? Text(crntDateFormat
                                          //                 .toString())
                                          //             : Text(formattedDate
                                          //                 .toString())),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                type1 != "F" && type2 != "T"
                                    ? CustomDatePicker(dateType: "To Date")
                                    : CustomDatePicker(dateType: "From Date "),
                                CustomDatePicker(dateType: "To Date"),
                                // ElevatedButton(
                                //   onPressed: () {},
                                //   child: Icon(Icons.arrow_downward),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),

          Consumer<Controller>(builder: (context, value, child) {
            {
              return Container(
                // color: P_Settings.datatableColor,
                height: size.height * 0.6,
                child: ListView.builder(
                  itemCount: value.reportList!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Ink(
                        height: size.height * 0.09,
                        decoration: BoxDecoration(
                          color: (index % 2 == 0)
                              ? P_Settings.datatableColor
                              : P_Settings.color4,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            // contentPadding: EdgeInsets.zero,
                            // dense: true,
                            minLeadingWidth: 10,
                            onTap: () {
                              setState(() {
                                buttonClicked = true;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage1()),
                                );
                              });
                              // print(buttonClicked);
                            },
                            title: Column(
                              children: [
                                Text(
                                  value.reportList![index]['report_name'],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Text(
                                  value.reportList![index]['filter_names'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////
