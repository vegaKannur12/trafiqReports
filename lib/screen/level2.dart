import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:reports/components/customColor.dart';
import 'package:reports/components/customDatePicker.dart';
import 'package:reports/components/datatableCompo.dart';
import 'package:reports/controller/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage1 extends StatefulWidget {
  @override
  State<HomePage1> createState() {
    return _HomePage1State();
  }
}

class _HomePage1State extends State<HomePage1> {
  Widget? appBarTitle;
  DateTime currentDate = DateTime.now();
  bool qtyvisible = false;
  String? formattedDate;
  String? fromDate;
  String? toDate;
  String? crntDateFormat;
  Icon actionIcon = Icon(Icons.search);
  List<bool> visible = [];
  List<bool> isExpanded = [];
  late ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  List<String> listString = ["Main Heading", "level1", "level2"];
  List<String> listShrinkData = ["F1", "F2", "F3"];

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

  toggle(int i) {
    setState(() {
      isExpanded[i] = !isExpanded[i];
      visible[i] = !visible[i];
    });
  }

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
    fromDate = DateFormat('dd-MM-yyyy').format(currentDate);
  }

  Future _selectToDate(BuildContext context) async {
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
    toDate = DateFormat('dd-MM-yyyy').format(currentDate);
  }
/////////////////////////////////////////////////////////////////
  @override
  void initState() {
    // Provider.of<Controller>(context, listen: false).getReportApi();
    isExpanded = List.generate(listString.length, (index) => false);
    visible = List.generate(listString.length, (index) => true);
    // print("initstate");
    setSharedPreftojsondata();
    getShared();
    createShrinkedData();
    //print("jsondata----$jsondata");
    super.initState();
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
    // print("height : ${size.height} && width : ${size.width} ");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: appBarTitle,
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
                  if (this.actionIcon.icon == Icons.close) {
                    // print("hellooo");
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text("Report");
                    // Provider.of<Controller>(context, listen: false)
                    //     .setIssearch(false);
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
                    if (value.reportList != null &&
                        value.reportList.isNotEmpty) {
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
                                                      Icons.calendar_today)),
                                              fromDate == null
                                                  ? Text(
                                                      crntDateFormat.toString())
                                                  : Text(toDate.toString())
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    _selectFromDate(context);
                                                  },
                                                  icon: Icon(
                                                      Icons.calendar_today)),
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
                                            icon: Icon(Icons.calendar_today)),
                                        fromDate == null
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
                                                          onPressed: () {},
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
                return Container(
                  // color: P_Settings.datatableColor,
                  height: size.height * 0.71,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listString.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Ink(
                                decoration: BoxDecoration(
                                  color: P_Settings.color4,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => HomePage()),
                                    // );
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
                                              size: 18,
                                            )
                                          : Icon(
                                              Icons.arrow_downward,
                                              // actionIcon.icon,
                                              size: 18,
                                            ),
                                      onPressed: () {
                                        toggle(index);
                                        // print("json-----${json}");
                                      }),
                                ),
                              ),
                              SizedBox(height: size.height * 0.004),
                              Visibility(
                                visible: visible[index],
                                child: DataTableCompo(
                                    decodd: encodedShrinkdata,
                                    type: "shrinked"),
                              ),
                              Visibility(
                                visible: isExpanded[index],
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

///////////////////////alert box for button click //////////////////////////////////////
