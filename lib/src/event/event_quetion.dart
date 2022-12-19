import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/event/event_index.dart';
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
              maxLength: 10,
              decoration: InputDecoration(labelText: "${event.question1}"),
              onChanged: (text) {
                ans1 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              maxLength: 10,
              decoration: InputDecoration(labelText: "${event.question2}"),
              onChanged: (text) {
                ans2 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              maxLength: 10,
              decoration: InputDecoration(labelText: "${event.question3}"),
              onChanged: (text) {
                ans3 = text;
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          FirebaseFirestore.instance.collection("event").doc(event.documentID).update({
      "ans1": ans1,
      "ans2": ans2,
      "ans3": ans3
    });
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EventIndex(),
            ),
          );
        },
        icon: const Icon(Icons.send),
        label: const Text("解答を送信"),
        backgroundColor: const Color.fromARGB(255, 255, 82, 70),
      ),
    );
  }
}
