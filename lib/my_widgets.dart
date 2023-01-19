import 'package:enpit_weee/src/model/user_model.dart';
import 'package:flutter/material.dart';

AppBar myAppBar(String mytitle) {
  return AppBar(
    title: Text(
      mytitle,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 5,
  );
}

AppBar myAppBarWithDrawer(String mytitle,  GlobalKey<ScaffoldState> scaffoldKey){
  return AppBar(
    title: Text(
      mytitle,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 5,
    leading: IconButton(
      onPressed: () => scaffoldKey.currentState!.openDrawer(),
      icon: const Icon(Icons.account_circle),
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
          color: Colors.white60,
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
          color: const Color(0xff1976d2),
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
