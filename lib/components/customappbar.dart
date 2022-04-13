import 'package:flutter/material.dart';
import 'package:reports/components/customColor.dart';

class CustomAppbar extends StatefulWidget {
  String title;
  CustomAppbar({required this.title});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
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
    // setState(() {
    //   searchkey = value;
    //   if (value.isEmpty) {
    //     isSearch = false;
    //   } else {
    //     isSearch = true;
    //     // newList =
    //     // Provider.of<Controller>(context, listen: false)
    //     //     .categoryList!
    //     //     .where((cat) =>
    //     //         cat["mc_name"].toUpperCase().startsWith(value.toUpperCase()))
    //     //     .toList();
    //   }
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appBarTitle = Text(widget.title.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: appBarTitle,
      actions: [
        IconButton(
            onPressed: () {
              togle();
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  print("hai");
                  _controller.clear();
                  this.actionIcon = Icon(Icons.close);
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
                    // Provider.of<Controller>(context, listen: false)
                    //     .setIssearch(false);
                  }
                }
              });
            },
            icon: actionIcon),
        Visibility(
          visible: visible,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.done)),
        )
      ],
    );
  }
}
