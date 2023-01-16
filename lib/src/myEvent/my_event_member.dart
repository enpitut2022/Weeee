import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyEventMember extends StatefulWidget {
  MyEventMember({required this.event, super.key});
  Event event;

  @override
  State<MyEventMember> createState() => _MyEventMemberState();
}

class _MyEventMemberState extends State<MyEventMember> {
  UserModals loggedUser = UserModals();
  String uuid = "";
  List namelist = [];
  Set member = Set();
  UserModals user = UserModals();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      loggedUser = UserModals.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('同行者'),
        ),
        body: ListView.builder(
          itemCount: widget.event.participant.length,
          itemBuilder: (context, index) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(widget.event.participant[index])
                .get()
                .then(
              (value) {
                user = UserModals.fromMap(value.data());
                member.add(user.name);
              },
            );
            namelist = member.toList();

            // namelist = uid2name(widget.event.participant[index]).toList();
            print("--------------list::::---$namelist-------------");
            return Text(
                "${namelist[index]}  ${widget.event.participant[index]}");
          },
        ));
  }

  // Set uid2name(String uid) {
  //   UserModals user = UserModals();
  //   print("----------------uid:::-${uid}-------------");
  //   FirebaseFirestore.instance.collection("users").doc(uid).get().then(
  //     (value) {
  //       user = UserModals.fromMap(value.data());
  //       member.add(user.name);
  //       print("--------------member::::---$member-------------");
  //     },
  //   );
  //   return member;
  // }
}
