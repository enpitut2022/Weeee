import 'package:enpit_weee/src/event/event_index.dart';
import 'package:flutter/material.dart';

class EventDetailQuestion extends StatelessWidget {
  //eventモデルを使用するときに使う　12/7
  // EventDetailQuestion({required this.event, super.key});
  // Event event;
  EventDetailQuestion({super.key});

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
          children: const [
            Text("誰推しですか？"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
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
