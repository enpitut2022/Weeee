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

  Event._({
    required this.name,
    required this.date,
    required this.place,
    required this.gender,
    required this.age,
    required this.people,
    required this.atmosphere,
    required this.greeting
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
      greeting: _snapshot["greeting"]
    );
  }
}
