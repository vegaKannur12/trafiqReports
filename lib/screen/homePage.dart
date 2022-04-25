import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reports/components/customColor.dart';
import 'package:reports/components/customDatePicker.dart';
import 'package:reports/controller/controller.dart';
import 'package:reports/screen/level2.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  Widget? appBarTitle;
  Icon actionIcon = Icon(Icons.search);
  late ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  DateTime currentDate = DateTime.now();
  bool qtyvisible = false;
  String? formattedDate;
  String? crntDateFormat;
  String searchkey = "";
  bool isSearch = false;
  bool visible = true;
  String searchKey = "";
  bool isSelected = true;
  bool buttonClicked = false;
  List newList = [];

  _onSelectItem(int index, String reportType) {
    _selectedIndex.value = index;
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  void initState() {
    Provider.of<Controller>(context, listen: false).getReportApi();
    _controller.clear();
    super.initState();
    Provider.of<Controller>(context, listen: false).getCategoryReport();
  }

  void togle() {
    setState(() {
      visible = !visible;
    });
  }

  onChangedValue(String value) {
    setState(() {
      searchKey = value;
      if (searchKey.isNotEmpty || isSearch) {
        newList = Provider.of<Controller>(context, listen: false)
            .reportList!
            .where((user) =>
                user["report_name"].toLowerCase().contains(value.toLowerCase()))
            .toList();
        print("list...... $newList");
      } else if (isSearch = false) {
        print("No data found");
      }
    });
  }

  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
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

    for (var i = 0;
         i < Provider.of<Controller>(context, listen: false).reportCategoryList.length;
        i++) {
      // var d =Provider.of<Controller>(context, listen: false).drawerItems[i];
      drawerOpts.add(Consumer<Controller>(builder: (context, value, child) {
        return ListTile(
            // leading: new Icon(d.icon),
            title: Text(
              value.reportCategoryList[i]["rg_name"],
              style: TextStyle(fontFamily: P_Font.kronaOne, fontSize: 17),
            ),
            selected: i == _selectedIndex.value,
            onTap: () {
              // _onSelectItem(i, value.reportCategoryList[i]["rg_name"]);
              // Navigator.push(
              //                 context,
              //                 MaterialPageRoute(builder: (context) => Level1Sample()),
              //               );
            });
      }));
    }
    /////////////////////////////////////////////////////////////////////
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          IconButton(
            icon: actionIcon,
            onPressed: () {
              togle();
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  print("hai");
                  _controller.clear();
                  this.actionIcon = Icon(Icons.close);
                  newList.clear();
                  this.appBarTitle = TextField(
                      controller: _controller,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      onChanged: ((value) {
                        onChangedValue(value);
                        // _controller.clear();
                      }),
                      cursorColor: Colors.black);
                } else {
                  if (this.actionIcon.icon == Icons.close) {
                    _controller.clear();
                    newList.clear();
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text("Report");
                    // Provider.of<Controller>(context, listen: false)
                    //     .isSearch(false);
                  }
                }
              });
            },
          ),
        ],
      ),
      // appBar: AppBar(
      //   // title: Text(widget._draweItems[_selectedIndex].title),
      //   title: Text("Reports"),
      // ),
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
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.045,
            ),
            Container(
              height: size.height * 0.2,
              width: size.width * 1,
              color: P_Settings.color3,
              child: Row(
                children: [
                  SizedBox(height: size.height * 0.07, width: size.width*0.03,),
                  Icon(Icons.list_outlined,color: Colors.white,),
                  SizedBox(width: size.width*0.04),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
            Column(children: drawerOpts)
          ],
        ),
      ),
      body: Column(children: [
        // Text(widget._draweItems[_selectedIndex].title),
        buttonClicked
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
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
                if (value.reportList != null && value.reportList!.isNotEmpty) {
                  type = value.reportList![4]["report_elements"].toString();
                  List<String> parts = type!.split(',');
                  type1 = parts[0].trim(); // prefix: "date"
                  type2 = parts[1].trim(); // prefix: "date"
                }
                {
                  return Container(
                    child: Container(
                      height: size.height * 0.15,
                      color: P_Settings.dateviewColor,
                      child: Column(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Container(
                                    width: size.width * 0.2,
                                    height: size.height * 0.1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Row(
                                          children: [],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                type1 != "F" && type2 != "T"
                                    ? CustomDatePicker(dateType: "To Date")
                                    : CustomDatePicker(dateType: "From Date "),
                                CustomDatePicker(dateType: "To Date"),
                                qtyvisible
                                    ? SizedBox(
                                        width: size.width * 0.2,
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_downward,
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
                                          icon: const Icon(Icons.arrow_upward,
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
                                        height: size.height * 0.08,
                                        width: size.width * 1,
                                        child: Row(
                                          children: [
                                            // Flexible(
                                            //   child: ElevatedButton(
                                            //       onPressed: () {},
                                            //       child: Text(
                                            //           value.specialelements[0]
                                            //               ["label"])),
                                            // ),
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
        isSearch == false || newList.isEmpty
            ? newList.isEmpty
                ? Consumer<Controller>(builder: (context, value, child) {
                    {
                      return Container(
                        height: size.height * 0.73,
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
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 100), () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage1(),
                                          ),
                                        );
                                      });
                                    },
                                    title: Column(
                                      children: [
                                        Text(
                                          value.reportList![index]
                                              ['report_name'],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Text(
                                          value.reportList![index]
                                              ['filter_names'],
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
                : Consumer<Controller>(builder: (context, value, child) {
                    {
                      return Container(
                        height: size.height * 0.73,
                        child: ListView.builder(
                          itemCount: newList.length,
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
                                      });
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage1(),
                                          ),
                                        );
                                      });
                                    },
                                    title: Column(
                                      children: [
                                        Text(
                                          newList[index]["report_name"],
                                          // value.reportList![index]['report_name'],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Text(
                                          newList[index]["filter_names"],
                                          // value.reportList![index]['filter_names'],
                                          style: const TextStyle(fontSize: 12),
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
            : Container(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text("No Data Found..."),
                      ),
                    ],
                  ),
                ),
              )
      ]),
    );
  }
}
