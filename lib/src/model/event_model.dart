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
  final String? startplace;
  final String? starttime;
  final String? goalplace;
  final String? goaltime;

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
      required this.startplace,
      required this.starttime,
      required this.goalplace,
      required this.goaltime});

  factory Event.fromSnapshot(DocumentSnapshot snapshot) {
    final _snapshot = snapshot.data() as Map<String, dynamic>;
    return Event._(
      name: _snapshot["name"],
      date: _snapshot["date"].toDate(), // timestamp型からdatetime型へ
      prefec: _snapshot["prefec"],
      place: _snapshot["place"],
      gender: _snapshot["gender"],
      age: _snapshot["age"],
      people: _snapshot["num"],
      genre: _snapshot["genre"],
      background: _snapshot["background"],
      startplace: _snapshot["startPlace"],
      starttime: _snapshot["startTime"],
      goalplace: _snapshot["goalPlace"],
      goaltime: _snapshot["goalTime"],
    );
  }
}
