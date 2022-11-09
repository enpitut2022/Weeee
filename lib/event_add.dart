import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/home.dart';
import 'package:flutter/material.dart';

//イベントの入力画面
//firebaseのeventという名前のcollectionにデータを追加
class eventAddPage extends StatefulWidget {
  @override
  _eventAddPageState createState() => _eventAddPageState();
}

class _eventAddPageState extends State<eventAddPage> {
  final TextEditingController _eventName = TextEditingController();
  final TextEditingController _eventDate = TextEditingController();
  final TextEditingController _eventPlace = TextEditingController();
  final TextEditingController _memberNum = TextEditingController();
  final TextEditingController _gender = TextEditingController();

  @override
  void dispose() {
    _eventName.dispose();
    _eventDate.dispose();
    _eventPlace.dispose();
    _memberNum.dispose();
    _gender.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("イベント入力"),
        ),
        body: Column(
          //イベントを入力するフォーム -> TextField()
          children: [
            Padding(padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _eventName,
              autofocus: true,
              decoration: const InputDecoration(hintText: "イベント名"),
            ),),
            Padding(padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _eventPlace,
              decoration: const InputDecoration(hintText: "イベント場所"),
            ),),
            Padding(padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _gender,
              decoration: const InputDecoration(hintText: "同行者性別"),
            ),),
            
            //型がstring以外の時のデータの受け渡しを勉強する
            // TextField(
            //   controller: _eventDate,
            //   autofocus: true,
            //   decoration: const InputDecoration(hintText: "イベント日時"),
            // ),
            // TextField(
            //   controller: _memberNum,
            //   decoration: const InputDecoration(hintText: "同行者人数"),
            // ),
            //ボタンを押して追加
            ElevatedButton(
              onPressed: () {
                //firestoreの'name'に右辺の値を代入する
                final document = <String, dynamic>{
                  'name': _eventName.text,
                  "place": _eventPlace.text,
                  "gender": _gender.text,
                  // "str_date": _eventDate,
                  // "num":_memberNum,
                  'createdAt': Timestamp.fromDate(DateTime.now()),
                };
                FirebaseFirestore.instance
                    .collection('event')
                    .doc()
                    .set(document);
                setState(_eventName.clear);
                setState(_eventPlace.clear);
                setState(_gender.clear);
                // setState(_eventDate.clear);
                // setState(_memberNum.clear);

                Navigator.pop(context);
              },
              child: const Text('送信'),
            )
          ],
        ));
  }
}
