import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reports/components/customColor.dart';
import 'package:reports/controller/controller.dart';

class CustomAppbar extends StatefulWidget {
  String title;
  String level;
  CustomAppbar({required this.title, required this.level}) {
    print(title);
  }

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  //   final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  Widget? appBarTitle;
  Icon actionIcon = Icon(Icons.search);
  TextEditingController _controller = TextEditingController();
  bool visible = false;
  void togle() {
    setState(() {
      visible = !visible;
    });
  }

  onChangedValue(String value) {
    print("value inside function ---${value}");
    setState(() {
      Provider.of<Controller>(context, listen: false).searchkey = value;
      if (value.isEmpty) {
        Provider.of<Controller>(context, listen: false).isSearch = false;
      }
      if (value.isNotEmpty) {
        Provider.of<Controller>(context, listen: false).isSearch = true;
        Provider.of<Controller>(context, listen: false)
            .searchProcess(widget.level);
      }
    });
  }

  // @override
  // void didUpdateWidget(covariant CustomAppbar oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.title != oldWidget.title) {
  //     print("update----${widget.title.toString()}");
  //     appBarTitle = Text(widget.title.toString());
  //   } else {
  //     print("elseee");
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("initstate----${widget.title.toString()}");
    appBarTitle = Text(
      widget.title.toString(),
      style: TextStyle(fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("widget build context----${appBarTitle}");
    // final formKey = GlobalKey<FormState>();
    // print("widget build context----${widget.title.toString()}");
    return AppBar(
      backgroundColor: widget.level == "level1"
          ? P_Settings.l1appbarColor
          : widget.level == "level2"
              ? P_Settings.l2appbarColor
              : widget.level == "level3"
                  ? P_Settings.l3appbarColor
                  : null,
      title: appBarTitle,
      leading: IconButton(
        onPressed: () {
          if (widget.level == "level2") {
            setState(() {
               Provider.of<Controller>(context, listen: false).backButtnClicked =
                true;
            });
           
            print("backButtnClicked-----${Provider.of<Controller>(context, listen: false).backButtnClicked}");
            
            // print("resultCopy-----${Provider.of<Controller>(context, listen: false).resultCopy}");
          }
          Navigator.of(context).pop(true);
        },
        icon: Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
            onPressed: () {
              togle();
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  print("hai");
                  _controller.clear();
                  this.actionIcon = Icon(Icons.close);
                  print("this.appbar---${this.appBarTitle}");
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
                        print(value);
                        onChangedValue(value);
                      }),
                      cursorColor: Colors.black);
                } else {
                  if (this.actionIcon.icon == Icons.close) {
                    print("hellooo");
                    this.actionIcon = Icon(Icons.search);
                    this.appBarTitle = Text(widget.title);
                    Provider.of<Controller>(context, listen: false).isSearch =
                        false;
                    // Provider.of<Controller>(context, listen: false)
                    //     .setIssearch(false);
                  }
                }
              });
            },
            icon: actionIcon),
        // Visibility(
        //   visible: visible,
        //   child: IconButton(
        //       onPressed: () {
        //        Provider.of<Controller>(context, listen: false).isSearch=true;
        //        Provider.of<Controller>(context, listen: false).searchProcess(widget.level);
        //         // if (Provider.of<Controller>(context, listen: false).isSearch ==
        //         //     true) {
        //         //   setState(() {});
        //         //   //  =true;
        //         // }
        //       },
        //       icon: Icon(Icons.done)),
        // )
      ],
    );
  }
}
