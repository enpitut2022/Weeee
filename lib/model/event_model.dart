import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String name;
  final String date;
  final String place;
  final String gender;
  final int age;
  final int people;
  final String atmosphere;
  final String greeting;
  final String genre;
  final String background; // 募集した理由
  final String startplace;
  final String starttime;
  final String goalplace;
  final String goaltime;

  Event._(
      {required this.name,
      required this.date,
      required this.place,
      required this.gender,
      required this.age,
      required this.people,
      required this.atmosphere,
      required this.greeting,
      required this.genre,
      required this.background,
      required this.startplace,
      required this.starttime,
      required this.goalplace,
      required this.goaltime
      });

  factory Event.fromSnapshot(DocumentSnapshot snapshot) {
    final _snapshot = snapshot.data() as Map<String, dynamic>;
    return Event._(
      name: _snapshot["name"],
      date: _snapshot["date"],
      place: _snapshot["place"],
      gender: _snapshot["gender"],
      age: _snapshot["age"],
      people: _snapshot["num"],
      atmosphere: _snapshot["atmo"],
      greeting: _snapshot["greeting"],
      genre: _snapshot["genre"],
      background: _snapshot["background"],
      startplace: _snapshot["startPlace"],
      starttime: _snapshot["startTime"],
      goalplace: _snapshot["goalPlace"],
      goaltime: _snapshot["goalTime"],
    );
  }
}
