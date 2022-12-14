import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/event/event_quetion.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  EventDetail({required this.event, super.key});
  Event event;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  UserModals loggedUser = UserModals();

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
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント詳細'),
      ),
      body: Container(
        height: screenSize.height * 0.99,
        color: const Color.fromARGB(255, 214, 214, 214),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              //color: const Color.fromARGB(255, 201, 198, 243),
              alignment: const Alignment(0.0, 0),
              //color: Colors.blue,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "ジャンル　： ${widget.event.genre}",
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "都道府県　： ${widget.event.prefec}",
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "場所　： ${widget.event.place}",
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "日時　：　\n ${widget.event.date.year}年${widget.event.date.month}月${widget.event.date.day}日 ${widget.event.date.hour}時${widget.event.date.minute}分",
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "人数　： ${widget.event.people.toString()} 人",
                  style: const TextStyle(fontSize: 30),
                ),
                // SizedBox(
                //   height: screenSize.height * 0.03,
                // ),
                // Text(
                //   "推し　： ${event.favorite}",
                //   style: const TextStyle(fontSize: 30),
                // ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "ファン歴　： ${widget.event.fanhistory}",
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "参加回数　： ${widget.event.participation}",
                  style: const TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 36, 38, 32),
                          size: 100,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.event.gender,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${widget.event.age.toString()} 歳",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Bubble(
                        margin: const BubbleEdges.only(top: 10),
                        nip: BubbleNip.leftTop,
                        child: Text(
                          widget.event.background,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        // ここを押すと、チャットができるようになる？
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection("event")
              .doc(widget.event.documentID)
              .collection("participant")
              .add({'uid': loggedUser.uid,
              'name':loggedUser.name});

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailQuestion(event: widget.event),
              // fullscreenDialog: true,
            ),
          );
        },
        label: const Text("参加したい！"),
        backgroundColor: const Color.fromARGB(255, 255, 82, 70),
      ),
    );
  }
}
