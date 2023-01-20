import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class AddEventProvider extends ChangeNotifier {
  String? name;
  String? createUserName;
  String? createUserId;
  String? eventID;
  DateTime? date;
  String? prefec;
  String? place;
  String? gender;
  int? age;
  int? people;
  String? genre;
  String? background; // 募集した理由
  String? fanhistory;
  String? participation;
  String? question1;
  String? question2;
  String? question3;
  // String? ans1; // 12/19 参加者の回答分。イベント作成時にはnullの状態。
  // String? ans2;
  // String? ans3;

  Future addEvent() async {
    if (name == null || name == "") {
      throw "イベント名が入力されていません";
    }
    if (genre == null || genre == "-") {
      throw "ジャンルは -以外を選択してください";
    }
    if (prefec == null || prefec == "-") {
      throw "県は、-以外を選択してください";
    }
    if (place == null || place == "") {
      throw "場所が入力されていません";
    }
    if (gender == null || gender == "-") {
      throw "性別は、-以外を選択してください";
    }
    if (people == null || people == "") {
      throw "人数が入力されていません";
    }
    if (background == null || background == "") {
      throw "募集理由が入力されていません";
    }
    /*if (favorite == null || favorite == "") {
      throw "推しが入力されていません";//チーム・グループ＋人名がいい？
    }*/
    if (fanhistory == null || fanhistory == "") {
      throw "ファン歴が入力されていません";
    }
    if (participation == null || participation == "") {
      throw "観戦回数/参加回数が入力されていません";
    }
    if (question1 == null || question1 == "") {
      throw "質問1が入力されていません";
    }
    if (question2 == null || question2 == "") {
      throw "質問2が入力されていません";
    }
    if (question3 == null || question3 == "") {
      throw "質問3が入力されていません";
    }

    final eventID = FirebaseFirestore.instance.collection("event").doc();
    //firestoreに追加する
    await eventID.set({
      "documentID": eventID.id, // イベントのドキュメントID
      "createUserId": createUserId,
      "createUserName": createUserName,
      "name": name,
      "date": date, //datetime型は、自動でtimestamp型へ
      "place": place,
      "prefec": prefec,
      "gender": gender,
      "age": age,
      "num": people,
      "genre": genre,
      "background": background,
      "fanhistory": fanhistory,
      "participation": participation,
      "question1": question1,
      "question2": question2,
      "question3": question3,
      // "ans1": ans1,
      // "ans2": ans2,
      // "ans3": ans3,
    });
    // イベントの参加者に自分を追加
    await eventID.update({
      "participant": FieldValue.arrayUnion([createUserId])
    });
    final now = DateTime.now().toLocal().toIso8601String();
    // イベント名でチャットルームの作成
    await FirebaseFirestore.instance.collection('chat_room').doc(name).set({
      'name': name,
      'createdAt': now,
      'eventID': eventID.id,
    });
    await FirebaseFirestore.instance
        .collection("event")
        .doc(eventID.id)
        .collection("participant")
        .add({
      'uid': createUserId,
      'name': createUserName,
      'gender': gender,
      'old': age,
    });
  }
}
