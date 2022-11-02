import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(todoList[index]),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.fourteen_mp_rounded),
          onPressed: () async {
            final newListText = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return eventAddPage();
            }));
            setState(() {
              todoList.add(newListText);
            });
          },
        ));
  }
}

class eventAddPage extends StatefulWidget {
  @override
  _eventAddPageState createState() => _eventAddPageState();
}

class _eventAddPageState extends State<eventAddPage> {
  //入力されたデータを保存
  String _text = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("イベント入力"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _text,
            style: TextStyle(color: Colors.blue),
          ),
          TextField(
            onChanged: (String value) {
              setState(() {
                _text = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: Text("リスト追加"),
              onPressed: () {
                Navigator.of(context).pop(_text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
