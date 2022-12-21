import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/home_page.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:flutter/material.dart';

class EventDetailQuestion extends StatelessWidget {
  //eventモデルを使用するときに使う　12/7
  // EventDetailQuestion({required this.event, super.key});
  // Event event;
  EventDetailQuestion({required this.event, super.key});
  Event event;
  String ans1 = "";
  String ans2 = "";
  String ans3 = "";

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('募集者の質問'),
      ),
      body: Container(
        height: screenSize.height * 0.99,
        color: const Color.fromARGB(255, 214, 214, 214),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "${event.question1}"),
              onChanged: (text) {
                ans1 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(labelText: "${event.question2}"),
              onChanged: (text) {
                ans2 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(labelText: "${event.question3}"),
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
                  child: const Text("やめとく", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      )),
                  onPressed: () async {
                    FirebaseFirestore.instance
                        .collection("event")
                        .doc(event.documentID)
                        .update({"ans1": ans1, "ans2": ans2, "ans3": ans3});
                    await Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
                  },
                  child: const Text("回答を送信", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
