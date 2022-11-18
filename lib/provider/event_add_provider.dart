import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class AddEventProvider extends ChangeNotifier {
  String? name;
  String? date;
  String? place;
  String? gender;
  int? age;
  int? people;
  String? greeting;
  String? genre;
  String? background; // 募集した理由
  String? startplace;
  String? starttime;
  String? goalplace;
  String? goaltime;

  Future addEvent() async {
    if (name == null || name == "") {
      throw "名前が入力されていません";
    }
    if (date == null || date == "") {
      throw "日にちが入力されていません";
    }
    if (place == null || place == "") {
      throw "場所が入力されていません";
    }
    if (gender == null || gender == "") {
      throw "人数が入力されていません";
    }
    if (age == null || age == "") {
      throw "年齢が入力されていません";
    }
    if (people == null || people == "") {
      throw "人数が入力されていません";
    }
    if (background == null || background == "") {
      throw "募集理由が入力されていません";
    }
    if (greeting == null || greeting == "") {
      throw "一言が入力されていません";
    }
    // if (startplace == null || startplace == "") {
    //   throw "集合場所が入力されていません";
    // }
    // if (starttime == null || starttime == "") {
    //   throw "集合時間が入力されていません";
    // }
    // if (goalplace == null || goalplace == "") {
    //   throw "解散場所が入力されていません";
    // }
    // if (goaltime == null || goaltime == "") {
    //   throw "解散時間が入力されていません";
    // }

    //firestoreに追加する
    await FirebaseFirestore.instance.collection("event").add({
      "name": name,
      "date": date,
      "place": place,
      "gender": gender,
      "age": age,
      "num": people,
      "greeting": greeting,
      "genre": genre,
      "background": background,
      "startPlace": startplace,
      "startTime": starttime,
      "goalPlace": goalplace,
      "goalTime": goaltime
    });
  }
}
