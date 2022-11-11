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
  String? atmosphere;
  String? greeting;

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
      throw "名前が入力されていません";
    }
    if (people == null || people == "") {
      throw "日にちが入力されていません";
    }
    if (atmosphere == null || atmosphere == "") {
      throw "場所が入力されていません";
    }
    if (greeting == null || greeting == "") {
      throw "人数が入力されていません";
    }

    //firestoreに追加する
    await FirebaseFirestore.instance.collection("event").add({
      "name": name,
      "date": date,
      "place": place,
      "gender": gender,
      "age": age,
      "num": people,
      "atmo": atmosphere,
      "greeting": greeting,
    });
  }
}
