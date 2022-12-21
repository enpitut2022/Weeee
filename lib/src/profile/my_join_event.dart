import 'package:flutter/material.dart';

class MyJoinEvent extends StatelessWidget {
  MyJoinEvent({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('参加しているイベント'),
      ),
      body: Container(
        child: const Text("参加したイベントを表示"),
      ),
    );
  }
}
