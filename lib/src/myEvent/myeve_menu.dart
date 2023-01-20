import 'package:enpit_weee/my_widgets.dart';
import 'package:enpit_weee/src/myEvent/myeve_chat.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:enpit_weee/src/myEvent/myeve_member.dart';
import 'package:enpit_weee/src/myEvent/myeve_ans.dart';
import 'package:flutter/material.dart';

class MyEventMenu extends StatefulWidget {
  MyEventMenu({
    required this.event,
    required this.loggedUser,
    super.key,
  });
  Event event;
  UserModels loggedUser;

  @override
  State<MyEventMenu> createState() => _MyEventMenuState();
}

class _MyEventMenuState extends State<MyEventMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var yoko = myWidth(context) * 0.7;
    var tate = myHeight(context) * 0.15;
    return Scaffold(
      appBar: myAppBar('イベント情報'),
      body: Container(
        height: myHeight(context),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration:  BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: myColor("other"),
                    width: 1,
                  ),
                ),
              ),
              child: Text(
                widget.event.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(
              width: myWidth(context),
              height: myHeight(context) * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: tate,
                    width: yoko,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: myColor("main1"),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: (() async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyEventMember(
                                  event: widget.event,
                                  loggedUser: widget.loggedUser,
                                )));
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
                          backgroundColor: myColor("main1"),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      onPressed: (() async {
                        // チャットページへ画面遷移
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ChatRoom(
                              widget.event.documentID, widget.loggedUser);
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
                            backgroundColor:  myColor("main1"),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: (() async {
                          if (widget.event.createUserID ==
                              widget.loggedUser.uid) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AnswerMyEvent(
                                      event: widget.event,
                                      loggedUser: widget.loggedUser,
                                    )));
                          }
                        }),
                        child: (widget.event.createUserID ==
                                widget.loggedUser.uid)
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
