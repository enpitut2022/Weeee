import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String name;
  final DateTime date;
  final String prefec;
  final String place;
  final String gender;
  final int age;
  final int people;
  final String genre;
  final String background; // 募集した理由
  /*final String? startplace;
  final String? starttime;
  final String? goalplace;
  final String? goaltime;*/
  final String favorite;
  final String fanhistory;
  final String participation;
  final String question1;
  final String question2;
  final String question3;

  Event._(
      {required this.name,
      required this.date,
      required this.prefec,
      required this.place,
      required this.gender,
      required this.age,
      required this.people,
      required this.genre,
      required this.background,
      /*required this.startplace,
      required this.starttime,
      required this.goalplace,
      required this.goaltime}),*/
      required this.favorite,
      required this.fanhistory,
      required this.participation,
      required this.question1,
      required this.question2,
      required this.question3});

  factory Event.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Event._(
        name: data["name"],
        date: data["date"].toDate(), // timestamp型からdatetime型へ
        prefec: data["prefec"],
        place: data["place"],
        gender: data["gender"],
        age: data["age"],
        people: data["num"],
        genre: data["genre"],
        background: data["background"],
        /*startplace: data["startPlace"],
      starttime: data["startTime"],
      goalplace: data["goalPlace"],
      goaltime: data["goalTime"],*/
        favorite: data["favorite"],
        fanhistory: data["fanhistory"],
        participation: data["participation"],
        question1: data["question1"],
        question2: data["question2"],
        question3: data["question3"]);
  }
}
