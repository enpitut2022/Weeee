import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/home_page.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnswerDetail extends StatefulWidget {
  AnswerDetail({
    required this.event,
    required this.ans1,
    required this.ans2,
    required this.ans3,
    required this.gender,
    required this.old,
    required this.name,
    required this.uid,
    super.key,
  });
  Event event;
  final String ans1;
  final String ans2;
  final String ans3;
  final String gender;
  final int old;
  final String name;
  final String uid;

  @override
  State<AnswerDetail> createState() => _AnswerDetailState();
}

class _AnswerDetailState extends State<AnswerDetail> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('回答内容'),
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
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("回答者",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(
                              "名前：${widget.name}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "性別：${widget.gender}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "年齢：${widget.old.toString()} 歳",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Container(
                  width: double.infinity,
                  color: Color.fromARGB(255, 200, 223, 242),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "質問1　： ${widget.event.question1}",
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Text(
                        "回答1　： ${widget.ans1}",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Container(
                  width: double.infinity,
                  color: Color.fromARGB(255, 200, 223, 242),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "質問2　： ${widget.event.question2}",
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Text(
                        "回答2　： ${widget.ans2}",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Container(
                  width: double.infinity,
                  color: Color.fromARGB(255, 200, 223, 242),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "質問3　： ${widget.event.question3}",
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      Text(
                        "回答3　： ${widget.ans3}",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                      ),
                      onPressed: (() async {
                        // 同行者に追加されないことを通知する機能を作ろうとしたが後回し
                        // await FirebaseFirestore.instance
                        //     .collection("event")
                        //     .doc(widget.event.documentID)
                        //     .collection("participant")
                        //     .add({
                        //   'uid': widget.uid,
                        //   'name': widget.name,
                        //   'judge': 'rejected'
                        // });
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      }),
                      child: const Text("同行者に追加しない",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          )),
                      onPressed: () async {
                        // このボタンを押すと、answersコレクションに名前と回答が追加される
                        await FirebaseFirestore.instance
                            .collection("event")
                            .doc(widget.event.documentID)
                            .collection("participant")
                            .add({
                          'uid': widget.uid,
                          'name': widget.name,
                          'gender': widget.gender,
                          'old':widget.old,
                        });

                        // eventコレクション直下の配列に追加する処理
                        await FirebaseFirestore.instance
                            .collection("event")
                            .doc(widget.event.documentID)
                            .update({
                          "participant": FieldValue.arrayUnion([widget.uid])
                        });

                        await Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                      },
                      child: const Text(
                        "同行者に追加する",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
