import 'package:flutter/material.dart';

class EventDetail extends StatelessWidget{
  const EventDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
      ),
      body: const Center(
          child: Text('チャット画面', style: TextStyle(fontSize: 32.0))),
    );
  }
}