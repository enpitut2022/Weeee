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
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: '野球cds'),
                Tab(text: 'サッカー'),
                Tab(text: 'テニス'),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(child: Text('くもり', style: TextStyle(fontSize: 50))),
              Center(child: Text('雨', style: TextStyle(fontSize: 50))),
              Center(child: Text('晴れ', style: TextStyle(fontSize: 50))),
            ],
          ),
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

class eventAddPage extends StatefulWidget {
  @override
  _eventAddPageState createState() => _eventAddPageState();
}

class _eventAddPageState extends State<eventAddPage> {
  //入力されたデータを保存
  String _text_sex = "";
  String _text_character = "";
  String _text_age = "";
  String _text_event_name = "";
  String _text_event_time = "";
  String _text_event_place = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("イベント入力"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Input sex'),
            onChanged: (String value) {
              setState(() {
                _text_sex = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'Input character'),
            onChanged: (String value) {
              setState(() {
                _text_character = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'Input age'),
            onChanged: (String value) {
              setState(() {
                _text_age = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'Input event name'),
            onChanged: (String value) {
              setState(() {
                _text_event_name = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'Input event time'),
            onChanged: (String value) {
              setState(() {
                _text_event_time = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(labelText: 'Input event place'),
            onChanged: (String value) {
              setState(() {
                _text_event_place = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("リスト追加"),
              onPressed: () {
                Navigator.of(context).pop([
                  _text_sex,
                  _text_character,
                  _text_age,
                  _text_event_name,
                  _text_event_time,
                  _text_event_place
                ]);
              },
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル')),
          )
        ],
      ),
    );
  }
}
