import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/myEvent/myeve_chat.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:enpit_weee/src/myEvent/myeve_member.dart';
import 'package:enpit_weee/src/myEvent/myeve_ans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyEventMenu extends StatefulWidget {
  MyEventMenu({required this.event, super.key});
  Event event;

  @override
  State<MyEventMenu> createState() => _MyEventMenuState();
}

class _MyEventMenuState extends State<MyEventMenu> {
  UserModels loggedUser = UserModels();

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
    var screenSize = MediaQuery.of(context).size;
    var yoko = screenSize.width * 0.7;
    var tate = screenSize.height * 0.15;
    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント情報'),
      ),
      body: Container(
        height: screenSize.height * 0.99,
        color: const Color.fromARGB(255, 214, 214, 214),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              alignment: const Alignment(0.0, 0),
              height: 80,
              width: 500,
              margin: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
              ),
              child: Text(
                widget.event.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
            ),
            SizedBox(
              width: screenSize.width,
              height: screenSize.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: tate,
                    width: yoko,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: (() async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MyEventMember(event: widget.event)));
                      }),
                      child: const Text("同行者確認",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: tate,
                    width: yoko,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: (() async {
                        // チャットページへ画面遷移
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ChatRoom(widget.event.documentID);
                        }));
                      }),
                      child: const Text("チャット",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(
                    height: tate,
                    width: yoko,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: (() async {
                          if (widget.event.createUserID == loggedUser.uid) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AnswerMyEvent(event: widget.event)));
                          }
                        }),
                        child: (widget.event.createUserID == loggedUser.uid)
                            ? const Text("質問回答",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                            : const Text("質問回答 \n※イベント作成者のみ見れます",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 200, 197, 197),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
