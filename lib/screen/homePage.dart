import 'package:flutter/material.dart';
import 'package:reports/components/customDatePicker.dart';
import 'package:reports/components/customappbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchkey = "";
  bool isSearch = false;

  bool buttonClicked = false;
  List<String> drawerItems = ["level 1", "level 2", "level3"];
  // List<Map<String, dynamic>>? newList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppbar(title: "Reports"),
      ),

      ///////////////////////////////////////////////////////////////////
      drawer: Drawer(
        child: ListView.builder(
          itemCount: drawerItems.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.tab),
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Test(
                                  text: drawerItems[index],
                                )),
                      );
                    }),
                    title: Text(drawerItems[index]),
                  ),
                  // Divider(),
                ],
              ),
            );
          },
        ),
      ),
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
                  color: Colors.grey[200],
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
            height: size.height * 0.6,
            child: ListView.builder(
                itemCount: drawerItems.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        buttonClicked = true;
                      });
                      print(buttonClicked);
                    },
                    title: Text(drawerItems[index]),
                  );
                })),
          )
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////
class Test extends StatelessWidget {
  String? text;
  Test({this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text.toString())),
      body: Center(
        child: Text(
          text.toString(),
        ),
      ),
    );
  }
}
