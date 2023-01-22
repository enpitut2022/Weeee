import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class AddEventProvider extends ChangeNotifier {
  String? name;
  String? artist;
  String? createUserName;
  String? createUserId;
  String? eventID;
  DateTime? date;
  String? prefec;
  String? place;
  String? gender;
  int? age;
  int? people;
  String? background; // 募集した理由
  String? fanhistory;
  String? participation;
  String? question1;
  String? question2;
  String? question3;

  Future addEvent() async {
    if (name == null || name == "") {
      throw "イベント名が入力されていません";
    }
    if (artist == null || artist == "") {
      throw "アーティスト名が入力されていません";
    }
    if (prefec == null || prefec == "-") {
      throw "県は、-以外を選択してください";
    }
    if (place == null || place == "") {
      throw "場所が入力されていません";
    }
    if (background == null || background == "") {
      throw "募集理由が入力されていません";
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
      "artist": artist,
      "date": date, //datetime型は、自動でtimestamp型へ
      "place": place,
      "prefec": prefec,
      "gender": gender,
      "age": age,
      "num": people,
      "background": background,
      "fanhistory": fanhistory,
      "participation": participation,
      "question1": question1,
      "question2": question2,
      "question3": question3,
      "participant": FieldValue.arrayUnion([createUserId]), // イベントの参加者に自分を追加
    });
    print("==========\n nowの前まで \n=======");
    final now = DateTime.now().toLocal().toIso8601String();
    // イベント名でチャットルームの作成
    await FirebaseFirestore.instance.collection('chat_room').doc(name).set({
      'name': name,
      'createdAt': now,
      'eventID': eventID.id,
    });
    print("==========\n participantの前まで \n=======");
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
