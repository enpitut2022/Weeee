import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String name;
  final String date;
  final String place;
  final int people;

  Event._({
    required this.name,
    required this.date,
    required this.place,
    required this.people,
  });

  factory Event.fromSnapshot(DocumentSnapshot snapshot) {
    final _snapshot = snapshot.data() as Map<String, dynamic>;
    return Event._(
      name: _snapshot["name"],
      date: _snapshot["date"],
      place: _snapshot["place"],
      people: _snapshot["num"],
    );
  }
}
