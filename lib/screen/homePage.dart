// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:reports/components/customColor.dart';
import 'package:reports/components/customDatePicker.dart';
import 'package:reports/components/customappbar.dart';

class HomePage extends StatefulWidget {
    final _draweItems = [
    new DrawerItem("sales report ", Icons.report),
    new DrawerItem("purchase report", Icons.report),
    new DrawerItem("sales report", Icons.report)
  ];
  // HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return new _HomePageState();
  } 
}

class _HomePageState extends State<HomePage> {
  String searchkey = "";
  bool isSearch = false;
  int _selectedIndex = 0;
  bool isSelected = true;
  bool buttonClicked = false;
  List<String> drawerItems = ["level 1", "level 2", "level3"];
  // List<Map<String, dynamic>>? newList = [];


  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);

    Navigator.of(context).pop(); // close the drawer
  }


  @override
  Widget build(BuildContext context) {
    //////////////////////////////////////////
    List<Widget> drawerOpts = [];
    
    for (var i = 0; i <widget._draweItems.length; i++) {
      var d = widget._draweItems[i];
      drawerOpts.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    //////////////////////////////////////////
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(title: Text(widget._draweItems[_selectedIndex].title)),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppbar(title:widget. _draweItems[_selectedIndex].title),
      ),

      ///////////////////////////////////////////////////////////////////
      drawer: Drawer(
        child: new Column(
          children: <Widget>[
            Container(
              height: size.height * 0.2,
              color: P_Settings.color3,
            ),
            // UserAccountsDrawerHeader(
            //   accountEmail: new Text("email@gmail.com", style: TextStyle(fontSize: 18),),
            //   accountName: new Text("Your Name", style: TextStyle(fontSize: 16),),
            //   currentAccountPicture: new GestureDetector(
            //     // child: new CircleAvatar(
            //     //   backgroundImage: new NetworkImage(picsUrl),
            //     // ),
            //     onTap: () => print("This is your current account."),
            //   ),
            // ),
            Column(children: drawerOpts)
          ],
        ),
      ),
      // child: ListView.builder(
      //   itemCount: drawerItems.length,
      //   itemBuilder: (context, index) {
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         children: [
      //           ListTile(
      //             leading: Icon(Icons.tab),
      //             onTap: (() {

      //               // Navigator.push(
      //               //   context,
      //               //   MaterialPageRoute(
      //               //       builder: (context) => Test(
      //               //             text: drawerItems[index],
      //               //           )),
      //               // );

      //               Navigator.pop(context);
      //             }),
      //             title: Text(drawerItems[index]),
      //           ),
      //           // Divider(),
      //         ],
      //       ),
      //     );
      //   },
      // ),

      body: Column(
        children: [
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
                                  print("Icon button --${buttonClicked}");
                                  setState(() {
                                    buttonClicked = false;
                                  });
                                }),
                                child: Icon(Icons.calendar_month))),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: size.height * 0.2,
                  color: P_Settings.dateviewColor,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomDatePicker(dateType: "From Date"),
                          CustomDatePicker(dateType: "To Date"),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       ElevatedButton(
                      //         onPressed: () {},
                      //         child: Text("View"),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
          Container(
            // color: P_Settings.datatableColor,
            height: size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: drawerItems.length,
                itemBuilder: ((context, index) {
                  return Ink(
                    color: (index % 2 == 0)
                        ? P_Settings.datatableColor
                        : Color.fromARGB(255, 153, 202, 155),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        minLeadingWidth: 10,
                        onTap: () {
                          setState(() {
                            buttonClicked = true;
                          });
                          print(buttonClicked);
                        },
                        title: Text(drawerItems[index]),
                      ),
                      
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
