import 'package:enpit_weee/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:enpit_weee/chat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<String>> todoList = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('イベント一覧画面'),
          ),
          body: Container(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final newListText = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return eventAddPage();
              }));
              if (todoList != null) {
                setState(() {
                  todoList.add(newListText);
                });
              }
            },
          )),
    );
  }
}
