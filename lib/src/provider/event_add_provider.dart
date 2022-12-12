import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class AddEventProvider extends ChangeNotifier {
  String? name;
  DateTime? date;
  String? prefec;
  String? place;
  String? gender;
  int? age;
  int? people;
  String? genre;
  String? background; // 募集した理由
  //String? startplace;
  //String? starttime;
  //String? goalplace;
  //String? goaltime;
  String? favorite;
  String? fanhistory;
  String? participation;
  String? question1;
  String? question2;
  String? question3;

  Future addEvent() async {
    if (name == null || name == "") {
      throw "名前が入力されていません";
    }
    if (genre == null || genre == "-") {
      throw "ジャンルは、-以外を選択してください";
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

    //firestoreに追加する
    await FirebaseFirestore.instance.collection("event").add({
      "name": name,
      "date": date, //datetime型は、自動でtimestamp型へ
      "place": place,
      "prefec": prefec,
      "gender": gender,
      "age": age,
      "num": people,
      "genre": genre,
      "background": background,
      //"startPlace": startplace,
      //"startTime": starttime,
      //"goalPlace": goalplace,
      //"goalTime": goaltime
      "favorite": favorite,
      "fanhistory": fanhistory,
      "participation": participation,
      "question1": question1,
      "question2": question2,
      "question3": question3
    });
  }
}
