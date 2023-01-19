import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/my_widgets.dart';
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
  UserModels loggedUser = UserModels();
  String uuid = "";
  List namelist = [];
  Set member = Set();
  UserModels user = UserModels();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      loggedUser = UserModels.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('同行者'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("event").doc(widget.event.documentID).collection("participant").snapshots(),
        builder: ( (context, snapshot) {
          // データが取得できた場合
          if (snapshot.hasData) {
            final List<DocumentSnapshot> member = snapshot.data!.docs;
            return ListView(
              children: member.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc['name']),
                    subtitle: Text("${doc['old']}歳　${doc['gender']}"),
                    leading: const Icon(Icons.account_circle),
                  ),
                );
              }).toList(),
            );
          }
          // データが読込中の場合
          return const CircularProgressIndicator();
        })),
      // 1/18 participantコレクションを作らなくてもいいようにしたかった
      // body: ListView.builder(
      //   itemCount: widget.event.participant.length,
      //   itemBuilder: (context, index) {
      //     FirebaseFirestore.instance
      //         .collection("users")
      //         .doc(widget.event.participant[index])
      //         .get()
      //         .then(
      //       (value) {
      //         user = UserModels.fromMap(value.data());
      //         member.add(user.name);
      //       },
      //     );
      //     namelist = member.toList();

      //     // namelist = uid2name(widget.event.participant[index]).toList();
      //     print("--------------list::::---$namelist-------------");
      //     return Text("${namelist[index]}  ${widget.event.participant[index]}");
      //   },
      // ),
    );
  }

  // Set uid2name(String uid) {
  //   UserModels user = UserModels();
  //   print("----------------uid:::-${uid}-------------");
  //   FirebaseFirestore.instance.collection("users").doc(uid).get().then(
  //     (value) {
  //       user = UserModels.fromMap(value.data());
  //       member.add(user.name);
  //       print("--------------member::::---$member-------------");
  //     },
  //   );
  //   return member;
  // }
}
