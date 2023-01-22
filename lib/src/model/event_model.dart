import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String documentID; // イベントID
  final String createUserID; // イベント作成者uid
  final String createUserName;
  final String name; // イベント名
  final String artist;
  final DateTime date;
  final String prefec;
  final String place;
  final String gender;
  final int age;
  final int people;
  final String background; // 募集した理由
  final String fanhistory;
  final String participation;
  final String question1;
  final String question2;
  final String question3;
  // final String ans1;
  // final String ans2;
  // final String ans3;
  final List participant;

  Event._({
    required this.documentID,
    required this.createUserID,
    required this.createUserName,
    required this.name,
    required this.artist,
    required this.date,
    required this.prefec,
    required this.place,
    required this.gender,
    required this.age,
    required this.people,
    required this.background,
    required this.fanhistory,
    required this.participation,
    required this.question1,
    required this.question2,
    required this.question3,
    // required this.ans1,
    // required this.ans2,
    // required this.ans3,
    required this.participant,
  });

  factory Event.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Event._(
        //19ko
        documentID: data["documentID"],
        createUserID: data["createUserId"],
        createUserName: data["createUserName"],
        name: data["name"],
        artist: data["artist"],
        date: data["date"].toDate(), // timestamp型からdatetime型へ
        prefec: data["prefec"],
        place: data["place"],
        gender: data["gender"],
        age: data["age"],
        people: data["num"],
        background: data["background"],
        fanhistory: data["fanhistory"],
        participation: data["participation"],
        question1: data["question1"],
        question2: data["question2"],
        question3: data["question3"],
        // ans1: data["ans1"],
        // ans2: data["ans2"],
        // ans3: data["ans3"],
        participant: data["participant"]);
  }
}
