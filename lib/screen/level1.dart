import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reports/components/customColor.dart';
import 'package:reports/components/customDatePicker.dart';
import 'package:reports/components/customappbar.dart';
import 'package:reports/components/datatableCompo.dart';
import 'package:reports/components/expandedTable.dart';
import 'package:reports/components/selectDate.dart';
import 'package:reports/components/shrinkedDatattable.dart';
import 'package:reports/controller/controller.dart';
import 'package:reports/screen/level2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelOne extends StatefulWidget {
  String old_filter_where_ids;
  String filter_id;
  String tilName;
  LevelOne(
      {required this.old_filter_where_ids,
      required this.filter_id,
      required this.tilName});

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
  var encodedTablejson;
  // List<bool> visible = [];
  // List<bool> isExpanded = [];
  late ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  List<String> listString = ["Main Heading", "level1", "level2"];
  List<String> listShrinkData = ["F1", "F2", "F3"];
  String? old_filter_where_ids;
  String? filter1;
  // String searchkey = "";
  // bool isSearch = false;
  bool datevisible = true;
  SelectDate selectD = SelectDate();
  bool isSelected = true;
  bool buttonClicked = false;
  List<Map<String, dynamic>> tablejson = [];
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
  // String? dateFromShared;
  // String? datetoShared;
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

  setList() {
    jsonList.clear();
    jsondata.map((jsonField) {
      jsonList.add(jsonField);
    }).toList();
    //print("json list--${jsonList}");
  }

///////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
  @override
  void initState() {
    //print("jsondata----$jsondata");
    super.initState();
    print(
        "from date from initstate---${Provider.of<Controller>(context, listen: false).fromDate}");
    // dateFromShared = Provider.of<Controller>(context, listen: false).fromDate;
    // datetoShared = Provider.of<Controller>(context, listen: false).todate;

    // crntDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
    print(crntDateFormat);

    setSharedPreftojsondata();
    getShared();
    createShrinkedData();
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (BuildContext context, int selectedValue, Widget? child) {
              return CustomAppbar(
                // title: "",
                title: widget.tilName,
                level: 'level1',
              );
            }),
      ),

      ///////////////////////////////////////////////////////////////////

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
                                                    selectD.selectDate(
                                                        context,
                                                        "level1",
                                                        widget.filter_id,
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .old_filter_where_ids!,
                                                        "from date");
                                                  },
                                                  icon: Icon(
                                                      Icons.calendar_month)),
                                              selectD.fromDate == null
                                                  ? InkWell(
                                                      onTap: () {
                                                        selectD.selectDate(
                                                            context,
                                                            "level1",
                                                            widget.filter_id,
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .old_filter_where_ids!,
                                                            "from date");
                                                      },
                                                      child: Text(Provider.of<
                                                                  Controller>(
                                                              context,
                                                              listen: false)
                                                          .fromDate
                                                          .toString()))
                                                  : InkWell(
                                                      onTap: (() {
                                                        selectD.selectDate(
                                                            context,
                                                            "level1",
                                                            widget.filter_id,
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .old_filter_where_ids!,
                                                            "from date");
                                                      }),
                                                      child: Text(selectD
                                                          .fromDate
                                                          .toString()))
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    selectD.selectDate(
                                                        context,
                                                        "level1",
                                                        widget.filter_id,
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .old_filter_where_ids!,
                                                        "from date");
                                                  },
                                                  icon: Icon(
                                                      Icons.calendar_month)),
                                              selectD.fromDate == null
                                                  ? InkWell(
                                                      onTap: (() {
                                                        selectD.selectDate(
                                                            context,
                                                            "level1",
                                                            widget.filter_id,
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .old_filter_where_ids!,
                                                            "from date");
                                                      }),
                                                      child: Text(Provider.of<
                                                                  Controller>(
                                                              context,
                                                              listen: false)
                                                          .fromDate
                                                          .toString()))
                                                  : InkWell(
                                                      onTap: () {
                                                        selectD.selectDate(
                                                            context,
                                                            "level1",
                                                            widget.filter_id,
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .old_filter_where_ids!,
                                                            "from date");
                                                      },
                                                      child: Text(selectD
                                                          .fromDate
                                                          .toString()))
                                            ],
                                          ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              selectD.selectDate(
                                                  context,
                                                  "level1",
                                                  widget.filter_id,
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .old_filter_where_ids!,
                                                  "to date");
                                            },
                                            icon: Icon(Icons.calendar_month)),
                                        selectD.toDate == null
                                            ? InkWell(
                                                onTap: () {
                                                  selectD.selectDate(
                                                      context,
                                                      "level1",
                                                      widget.filter_id,
                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .old_filter_where_ids!,
                                                      "to date");
                                                },
                                                child: Text(
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .todate
                                                        .toString()))
                                            : InkWell(
                                                onTap: () {
                                                  selectD.selectDate(
                                                      context,
                                                      "level1",
                                                      widget.filter_id,
                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .old_filter_where_ids!,
                                                      "to date");
                                                },
                                                child: Text(
                                                    selectD.toDate.toString()))
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
                                            height: size.height * 0.07,
                                            width: size.width * 1.2,
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
                                                        width: size.width * 0.3,
                                                        // height: size.height*0.001,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            // shape: StadiumBorder(),

                                                            primary: P_Settings
                                                                .l1datatablecolor,
                                                            shadowColor:
                                                                P_Settings
                                                                    .color4,
                                                            // minimumSize:
                                                            //     Size(100, 100),
                                                            // maximumSize:
                                                            //     Size(100, 100),
                                                          ),
                                                          onPressed: () {
                                                            fromDate = fromDate ==
                                                                    null
                                                                ? Provider.of<
                                                                            Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .fromDate
                                                                    .toString()
                                                                : fromDate
                                                                    .toString();

                                                            toDate = toDate ==
                                                                    null
                                                                ? Provider.of<
                                                                            Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .todate
                                                                    .toString()
                                                                : toDate
                                                                    .toString();

                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .setDate(
                                                                    fromDate!,
                                                                    toDate!);

                                                            specialField = value
                                                                    .specialelements[
                                                                index]["value"];

                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .getSubCategoryReportList(
                                                                    specialField!,
                                                                    widget
                                                                        .filter_id,
                                                                    fromDate!,
                                                                    toDate!,
                                                                    widget
                                                                        .old_filter_where_ids,
                                                                    "level1");
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

            Provider.of<Controller>(context, listen: false).isSearch &&
                    Provider.of<Controller>(context, listen: false)
                            .newList
                            .length ==
                        0
                ? Container(
                    alignment: Alignment.center,
                    height: size.height * 0.6,
                    child: Text(
                      "No data Found!!!",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : Container(
                    height: size.height * 0.71,
                    child:
                        Consumer<Controller>(builder: (context, value, child) {
                      {
                        print(
                            "level1 report list${value.level1reportList.length}");

                        if (value.isLoading == true) {
                          return Container(
                            height: size.height * 0.6,
                            child: SpinKitPouringHourGlassRefined(
                                color: P_Settings.l1appbarColor),
                          );
                        }

                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.isSearch
                                ? value.newList.length
                                : value.level1reportList.length,
                            itemBuilder: (context, index) {
                              var jsonEncoded =
                                  json.encode(value.level1reportList[index]);

                              // Provider.of<Controller>(context, listen: false)
                              //     .datatableCreation(jsonEncoded, "level1","shrinked");

                              // String filter =
                              //     value.reportList[index]["filters"].toString();
                              // print("filter ..............$filter");
                              // List<String> parts = filter.split(',');
                              // old_filter_where_ids =
                              //     value.level1reportList[index]["acc_rowid"];

                              // filter1 = parts[1].trim();
                              // specialField = specialField == null
                              //     ? "1"
                              //     : specialField.toString();
                              // fromDate = fromDate == null
                              //     ? Provider.of<Controller>(context,
                              //             listen: false)
                              //         .fromDate
                              //         .toString()
                              //     : fromDate.toString();

                              // toDate = toDate == null
                              //     ? Provider.of<Controller>(context,
                              //             listen: false)
                              //         .todate
                              //         .toString()
                              //     : toDate.toString();

                              print("${value.level1reportList[index]}");

                              if (index < 0 ||
                                  index >= value.level1reportList.length) {
                                return const Offstage();
                              }
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Ink(
                                      decoration: BoxDecoration(
                                        color: P_Settings.l1datatablecolor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          print(
                                              "special field--${specialField}");
                                          specialField = specialField == null
                                              ? "1"
                                              : specialField.toString();
                                          fromDate = fromDate == null
                                              ? Provider.of<Controller>(context,
                                                      listen: false)
                                                  .fromDate
                                                  .toString()
                                              : fromDate.toString();

                                          toDate = toDate == null
                                              ? Provider.of<Controller>(context,
                                                      listen: false)
                                                  .todate
                                                  .toString()
                                              : toDate.toString();

                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .setDate(fromDate!, toDate!);
                                          String filter = value
                                              .reportList[index]["filters"]
                                              .toString();
                                          print("filter ..............$filter");
                                          List<String> parts =
                                              filter.split(',');
                                          filter1 = parts[1].trim();
                                          print(
                                              "filtersss ..............$filter1");

                                          old_filter_where_ids =
                                              widget.old_filter_where_ids +
                                                  value.level1reportList[index]
                                                      ["acc_rowid"] +
                                                  ",";
                                          print(
                                              "old_filter_where_ids--${old_filter_where_ids}");
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .setSpecialField(specialField!);
                                          Provider.of<Controller>(context,
                                                  listen: false)
                                              .getSubCategoryReportList(
                                                  specialField!,
                                                  filter1!,
                                                  fromDate!,
                                                  toDate!,
                                                  old_filter_where_ids!,
                                                  "level2");

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => LevelTwo(
                                                      hometileName:
                                                          widget.tilName,
                                                      level1tileName: value
                                                              .level1reportList[
                                                          index]["sg"],
                                                      old_filter_where_ids:
                                                          old_filter_where_ids!,
                                                      filter_id: filter1!,
                                                      tile: widget.tilName,
                                                    )),
                                          );
                                        },
                                        title: Center(
                                          child: Text(
                                            value.isSearch
                                                ? value.newList[index]["sg"]
                                                : value.level1reportList[index]
                                                            ["sg"] !=
                                                        null
                                                    ? value.level1reportList[
                                                        index]["sg"]
                                                    : "",
                                            // style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        // subtitle:
                                        //     Center(child: Text('/report page flow')),
                                        trailing: IconButton(
                                            color: P_Settings.l1appbarColor,
                                            icon: Provider.of<Controller>(
                                                        context,
                                                        listen: false)
                                                    .l1isExpanded[index]
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
                                              old_filter_where_ids = widget
                                                      .old_filter_where_ids +
                                                  value.level1reportList[index]
                                                      ["acc_rowid"];

                                              specialField =
                                                  specialField == null
                                                      ? "1"
                                                      : specialField.toString();
                                              fromDate = fromDate == null
                                                  ? Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .fromDate
                                                      .toString()
                                                  : fromDate.toString();

                                              toDate = toDate == null
                                                  ? Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .todate
                                                      .toString()
                                                  : toDate.toString();
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .getExpansionJson(
                                                      specialField!,
                                                      widget.filter_id,
                                                      fromDate!,
                                                      toDate!,
                                                      old_filter_where_ids!,
                                                      '',
                                                      "level1");
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .toggleData(index, "level1");

                                              tablejson =
                                                  Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .tableJson;

                                              print("tablejson --${tablejson}");

                                              print(
                                                  "tablejson length---${tablejson.length}");

                                              // print(
                                              // "tableJson-----${tablejson}");
                                              // encodedTablejson =
                                              //     json.encode(tablejson);
                                              Provider.of<Controller>(context,
                                                      listen: false)
                                                  .expandedtableCreation(
                                                      tablejson);
                                            }),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.004),
                                    Visibility(
                                      visible: Provider.of<Controller>(context,
                                              listen: false)
                                          .l1visible[index],
                                      // child:Text("haiii")

                                      child: ShrinkedDatatable(
                                        decodd: jsonEncoded,
                                        level: "level1",
                                      ),
                                    ),
                                    Consumer<Controller>(
                                      builder: (context, value, child) {
                                        return Visibility(
                                            visible: value.l1isExpanded[index],
                                            child: 
                                            // value.istabLoading
                                                // ? CircularProgressIndicator()
                                                // : 
                                                value.tableJson.isNotEmpty
                                                    ? ExpandedDatatable(
                                                        dedoded:value.tableJson,
                                                        level: "level1",
                                                      ):Container()
                                                    // : Container()
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                    }),
                  )
          ],
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////
