import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/my_widgets.dart';
import 'package:enpit_weee/src/home_page.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventDetailQuestion extends StatefulWidget {
  //eventモデルを使用するときに使う　12/7
  // EventDetailQuestion({required this.event, super.key});
  // Event event;
  EventDetailQuestion({
    required this.event,
    required this.loggedUser,
    super.key,
  });
  Event event;
  UserModels loggedUser;

  @override
  State<EventDetailQuestion> createState() => _EventDetailQuestionState();
}

class _EventDetailQuestionState extends State<EventDetailQuestion> {
  String ans1 = "";
  String ans2 = "";
  String ans3 = "";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: myAppBar('募集者の質問'),
      body: Container(
        height: myHeight(context) * 0.99,
        color: const Color.fromARGB(255, 214, 214, 214),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              decoration:
                  InputDecoration(labelText: "${widget.event.question1}"),
              onChanged: (text) {
                ans1 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: "${widget.event.question2}"),
              onChanged: (text) {
                ans2 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration:
                  InputDecoration(labelText: "${widget.event.question3}"),
              onChanged: (text) {
                ans3 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      )),
                  onPressed: (() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  }),
                  child: const Text("やめとく",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      )),
                  onPressed: () async {
                    // このボタンを押すと、answersコレクションに名前と回答が追加される
                    await FirebaseFirestore.instance
                        .collection("event")
                        .doc(widget.event.documentID)
                        .collection("answers")
                        .add({
                      'uid': widget.loggedUser.uid,
                      'name': widget.loggedUser.name,
                      'old': widget.loggedUser.old,
                      'gender': widget.loggedUser.gender,
                      'ans1': ans1,
                      'ans2': ans2,
                      'ans3': ans3,
                    });

                    // 1/15
                    // eventコレクションのans1,2,3ドキュメントは常にnullにする
                    // 質問の回答は、event > answers > ans1,2,3 に保存する

                    // await FirebaseFirestore.instance
                    //     .collection("event")
                    //     .doc(widget.event.documentID)
                    //     .update({"ans1": ans1, "ans2": ans2, "ans3": ans3});
                    await Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
                  },
                  child: const Text(
                    "回答を送信",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
