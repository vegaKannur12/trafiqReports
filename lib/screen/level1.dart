import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:reports/components/customColor.dart';
import 'package:reports/components/customDatePicker.dart';
import 'package:reports/components/datatableCompo.dart';
import 'package:reports/components/shrinkedDatattable.dart';
import 'package:reports/controller/controller.dart';
import 'package:reports/screen/level2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelOne extends StatefulWidget {
  String old_filter_where_ids;
  LevelOne({required this.old_filter_where_ids});

  @override
  State<LevelOne> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  String? specialField;
  Widget? appBarTitle;
  DateTime currentDate = DateTime.now();
  bool qtyvisible = false;
  String? formattedDate;
  String? fromDate;
  String? toDate;
  String? crntDateFormat;
  Icon actionIcon = Icon(Icons.search);
  // List<bool> visible = [];
  // List<bool> isExpanded = [];
  late ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  List<String> listString = ["Main Heading", "level1", "level2"];
  List<String> listShrinkData = ["F1", "F2", "F3"];
  String? old_filter_where_ids;
  String searchkey = "";
  bool isSearch = false;
  bool datevisible = true;

  bool isSelected = true;
  bool buttonClicked = false;

  List<Map<String, dynamic>> shrinkedData = [];
  List<Map<String, dynamic>> jsonList = [];
  var encoded;
  var decodd;
  var encodedShrinkdata;
  var decoddShrinked;
  final jsondata = [
    {
      "rank": "0",
      "a": "TLN10_BillNo",
      "b": "TLN10_MRNo",
      "c": "TLN50_PatientName",
      "d": "CRY10_Amt",
      "e": "CRY10_Paid",
      "f": "CRY10_Bal",
      "g": "TLN10_Name",
    },
    {
      "rank": "1",
      "a": "G202204027",
      "b": "TJAA2",
      "c": "PRATHYEESH MAKRERI KANNUR",
      "d": "472.5",
      "e": "372.5",
      "f": "100",
      "g": "Anu",
    },
    {
      "rank": "1",
      "a": "G202204026",
      "b": "TJAA2",
      "c": "PRATHYEESH MAKRERI KANNUR",
      "d": "1697.5",
      "e": "1397.5",
      "f": "300",
      "g": "Graha",
    }
  ];

  getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    decodd = prefs.getString("json");
  }

  setSharedPreftojsondata() async {
    //print("enterd into shared");
    encoded = json.encode(jsondata);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("encoded---$encoded");
    prefs.setString("json", encoded);
    // print("added to shred prefs");
  }

  _onSelectItem(int index, String reportType) {
    _selectedIndex.value = index;
    Navigator.of(context).pop(); // close the drawer
  }

  createShrinkedData() {
    shrinkedData.clear();
    // print("cleared---$shrinkedData");
    shrinkedData.add(jsondata[0]);
    shrinkedData.add(jsondata[jsondata.length - 1]);
    // print("shrinked data --${shrinkedData}");
    encodedShrinkdata = json.encode(shrinkedData);
  }

  // toggle(int i) {
  //   setState(() {
  //     isExpanded[i] = !isExpanded[i];
  //     visible[i] = !visible[i];
  //   });
  // }

  setList() {
    jsonList.clear();
    jsondata.map((jsonField) {
      jsonList.add(jsonField);
    }).toList();
    //print("json list--${jsonList}");
  }

///////////////////////////////////////////////////////////
  Future _selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2023));
    if (pickedDate != null) {
      setState(() {
        currentDate = pickedDate;
      });
    } else {
      print("please select date");
    }
    fromDate = DateFormat('dd-MM-yyyy').format(currentDate);
  }

/////////////////////////////////////////////////////////////////
  Future _selectToDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2023));
    if (pickedDate != null) {
      setState(() {
        currentDate = pickedDate;
      });
    } else {
      print("please select date");
    }
    toDate = DateFormat('dd-MM-yyyy').format(currentDate);
  }

/////////////////////////////////////////////////////////////////
  @override
  void initState() {
    //print("jsondata----$jsondata");
    super.initState();
    crntDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
    print(crntDateFormat);
    // Provider.of<Controller>(context, listen: false).getReportApi();

    // print("initstate");
    setSharedPreftojsondata();
    getShared();
    createShrinkedData();
    var length = Provider.of<Controller>(context, listen: false)
        .reportSubCategoryList
        .length;
    print(length);
    // isExpanded = List.generate(length, (index) => false);
    // visible = List.generate(length, (index) => true);
    // print("isExpanded---$isExpanded");
    // print("visible---$visible");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    List<Widget> drawerOpts = [];
    String? specialList;
    String? newlist;
    String? type;
    String? type1;
    String? type2;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: appBarTitle,
        // appBarTitle,
        actions: [
          IconButton(
            icon: actionIcon,
            onPressed: () {
              // toggle(i);
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  _controller.clear();
                  this.actionIcon = Icon(Icons.close);
                  this.appBarTitle = TextField(
                      controller: _controller,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      // onChanged: ((value) {
                      //   print(value);
                      //   onChangedValue(value);
                      // }),
                      cursorColor: Colors.black);
                } else {
                  if (this.actionIcon.icon == Icons.close &&
                      _controller.text.isNotEmpty) {
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle =
                        Consumer<Controller>(builder: (context, value, child) {
                      if (value.reportSubCategoryList != null &&
                          value.reportSubCategoryList.isNotEmpty) {
                        return Text(
                          value.reportSubCategoryList[0]["sg"],
                          style: TextStyle(fontSize: 16),
                        );
                      } else {
                        return Container();
                      }
                    });
                    // Provider.of<Controller>(context, listen: false)
                    //     .setIssearch(false);
                  } else {
                    if (this.actionIcon.icon == Icons.close) {
                      print("closed");
                      _controller.clear();
                      this.actionIcon = Icon(Icons.search);
                      this.appBarTitle = Consumer<Controller>(
                          builder: (context, value, child) {
                        if (value.reportSubCategoryList != null &&
                            value.reportSubCategoryList.isNotEmpty) {
                          return Text(
                            value.reportSubCategoryList[0]["sg"],
                            style: TextStyle(fontSize: 16),
                          );
                        } else {
                          return Container();
                        }
                      });
                    }
                  }
                }
              });
            },
          ),
        ],
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
      // drawer: Drawer(
      //   child: new Column(
      //     children: <Widget>[
      //       Container(
      //         height: size.height * 0.2,
      //         color: P_Settings.color3,
      //       ),
      //       Column(children: drawerOpts)
      //     ],
      //   ),
      // ),
      body: InteractiveViewer(
        child: Column(
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
                    if (value.reportList != null && value.reportList.isEmpty) {
                      type = value.reportList[4]["report_elements"].toString();
                      List<String> parts = type!.split(',');
                      type1 = parts[0].trim(); // prefix: "date"
                      type2 = parts[1].trim(); // prefix: "date"
                    }
                    {
                      return Container(
                        color: Colors.yellow,
                        // height: size.height * 0.27,
                        child: Container(
                          height: size.height * 0.14,
                          color: P_Settings.dateviewColor,
                          child: Column(
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        width: size.width * 0.1,
                                      ),
                                    ),
                                    type1 != "F" && type2 != "T"
                                        ? Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _selectFromDate(context);
                                                  },
                                                  icon: Icon(
                                                      Icons.calendar_month)),
                                              fromDate == null
                                                  ? Text(
                                                      crntDateFormat.toString())
                                                  : Text(fromDate.toString())
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _selectFromDate(context);
                                                  },
                                                  icon: Icon(
                                                      Icons.calendar_month)),
                                              fromDate == null
                                                  ? Text(
                                                      crntDateFormat.toString())
                                                  : Text(fromDate.toString())
                                            ],
                                          ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _selectToDate(context);
                                            },
                                            icon: Icon(Icons.calendar_month)),
                                        toDate == null
                                            ? Text(crntDateFormat.toString())
                                            : Text(toDate.toString())
                                      ],
                                    ),
                                    qtyvisible
                                        ? SizedBox(
                                            width: size.width * 0.2,
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.arrow_upward,
                                                  color: Colors.deepPurple),
                                              onPressed: () {
                                                setState(() {
                                                  qtyvisible = false;
                                                });
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            width: size.width * 0.2,
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.deepPurple),
                                              onPressed: () {
                                                setState(() {
                                                  qtyvisible = true;
                                                });
                                              },
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: qtyvisible,
                                child: Row(
                                  children: [
                                    Consumer<Controller>(
                                        builder: (context, value, child) {
                                      {
                                        return Flexible(
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            // color: P_Settings.datatableColor,
                                            height: size.height * 0.08,
                                            width: size.width * 1,
                                            child: Row(
                                              children: [
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const PageScrollPhysics(),
                                                  itemCount: value
                                                      .specialelements.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: SizedBox(
                                                        width: size.width * 0.2,
                                                        // height: size.height*0.001,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            // shape: StadiumBorder(),
                                                            shape: BeveledRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            primary: P_Settings
                                                                .color4,
                                                            shadowColor:
                                                                P_Settings
                                                                    .color4,
                                                            minimumSize:
                                                                Size(10, 20),
                                                            maximumSize:
                                                                Size(10, 20),
                                                          ),
                                                          onPressed: () {
                                                            specialField = value
                                                                    .specialelements[
                                                                index]["value"];
                                                          },
                                                          child: Text(
                                                            value.specialelements[
                                                                index]["label"],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    })
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            SizedBox(
              height: size.height * 0.03,
            ),
            Consumer<Controller>(builder: (context, value, child) {
              {
                print(value.reportSubCategoryList.length);

                if (value.isLoading == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  // color: P_Settings.datatableColor,
                  height: size.height * 0.71,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.reportSubCategoryList.length,
                      itemBuilder: (context, index) {
                        var jsonEncoded =
                            json.encode(value.reportSubCategoryList[index]);
                        // print("map---${value.reportSubCategoryList[index]}");
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Ink(
                                decoration: BoxDecoration(
                                  color: P_Settings.color4,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    String filter = value.reportList[index]
                                            ["filters"]
                                        .toString();
                                    print("filter ..............$filter");
                                    List<String> parts = filter.split(',');
                                    String filter1 = parts[1].trim();
                                    print("filtersss ..............$filter1");

                                    old_filter_where_ids =
                                        widget.old_filter_where_ids +
                                            value.reportSubCategoryList[index]
                                                ["acc_rowid"] +
                                            ",";
                                    print(
                                        "old_filter_where_ids--${old_filter_where_ids}");
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .getSubCategoryReportList(
                                            specialField!,
                                            filter1,
                                            fromDate!,
                                            toDate!,
                                            old_filter_where_ids!);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LevelTwo(
                                                old_filter_where_ids:
                                                    old_filter_where_ids!,
                                              )),
                                    );
                                  },
                                  title: Center(
                                    child: Text(
                                      value.reportSubCategoryList[index]
                                                  ["sg"] !=
                                              null
                                          ? value.reportSubCategoryList[index]
                                              ["sg"]
                                          : "",
                                      // style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  // subtitle:
                                  //     Center(child: Text('/report page flow')),
                                  trailing: IconButton(
                                      icon: Provider.of<Controller>(context,
                                                  listen: false)
                                              .isExpanded[index]
                                          ? Icon(
                                              Icons.arrow_upward,
                                              size: 18,
                                            )
                                          : Icon(
                                              Icons.arrow_downward,
                                              // actionIcon.icon,
                                              size: 18,
                                            ),
                                      onPressed: () {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .toggleData(index);
                                        // toggle(index);
                                        // print("json-----${json}");
                                      }),
                                ),
                              ),
                              SizedBox(height: size.height * 0.004),
                              Visibility(
                                visible: Provider.of<Controller>(context,
                                        listen: false)
                                    .visible[index],
                                // child:Text("haiii")

                                child: ShrinkedDatatable(decodd: jsonEncoded),
                              ),
                              Visibility(
                                visible: Provider.of<Controller>(context,
                                        listen: false)
                                    .isExpanded[index],
                                child: DataTableCompo(
                                    decodd: decodd, type: "expaded"),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
