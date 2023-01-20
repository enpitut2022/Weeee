import 'package:enpit_weee/src/model/user_model.dart';
import 'package:flutter/material.dart';

AppBar myAppBar(String mytitle) {
  return AppBar(
    title: Text(
      mytitle,
      style: TextStyle(color: myColor("other")),
    ),
    backgroundColor: myColor("base"),
    iconTheme: IconThemeData(color: myColor("other")),
    elevation: 5,
  );
}

AppBar myAppBarWithDrawer(
    String mytitle, GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    title: Text(
      mytitle,
      style: TextStyle(color: myColor("other")),
    ),
    backgroundColor: myColor("base"),
    iconTheme: IconThemeData(color: myColor("other")),
    elevation: 5,
    leading: IconButton(
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
      icon: Icon(Icons.account_circle, color: myColor("main1"),),
    ),
  );
}



Drawer myDrawer(UserModels user) {
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          //color: myColor("main1"),
          child: const Text("マイデータ"),
        ),
        showData(Icons.account_circle, "${user.name}"),
        showData(Icons.format_list_numbered_sharp, "${user.old}歳"),
        showData(Icons.people, "${user.gender}"),
      ],
    ),
  );
}

Widget showData(IconData ico, String s) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    ),
    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Icon(
          ico,
          color: myColor("main1"),
        ),
        const SizedBox(
          width: 50,
        ),
        Text(
          s,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ],
    ),
  );
}

Color myColor(String color) {
  String a = color;
  if (a == "base") {
    return Colors.white;
  } else if (a == "main1") {
    return Colors.lightBlue;
  } else if (a == "main22") {
    return Colors.pink.shade200;
  } else if (a == "red") {
    return Colors.redAccent.shade400;
  } else {
    return Colors.black;
  }
}

double myWidth(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  return screenSize.width;
}

double myHeight(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
  return screenSize.height;
}

BoxDecoration myDeco() {
  return BoxDecoration(
    border: Border.all(color: myColor("main1"), width: 10),
    borderRadius: BorderRadius.circular(20),
  );
}

Widget myBoxHeight(double size) {
  return SizedBox(height: size);
}

Widget myBoxWidth(double size) {
  return SizedBox(width: size);
}
