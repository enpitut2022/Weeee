import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventProvider {
  //コンストラクター
  EventProvider() {
    allEvents = _allEventsController.stream;
  }

  //コントローラー？
  final StreamController<List<Event>> _allEventsController = StreamController();

  //変数の宣言
  late final Stream<List<Event>> allEvents;

  void loadAllEvents() {
    final querySnapshot =
        FirebaseFirestore.instance.collection('event').snapshots();

    querySnapshot.listen(
      (event) {
        final events = event.docs.map((DocumentSnapshot doc) {
          //イベントの情報をここでfirebaseから取得している。
          return Event.fromSnapshot(doc);
        }).toList();

        _allEventsController.add(events);
      },
    );
  }

  // 自分が作ったイベント(参加することは確定)
  void loadMyEvents() {
    final querySnapshot = FirebaseFirestore.instance
        .collection('event')
        .where('createUserId',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    querySnapshot.listen(
      (event) {
        final events = event.docs.map((DocumentSnapshot doc) {
          //イベントの情報をここでfirebaseから取得している。
          return Event.fromSnapshot(doc);
        }).toList();

        _allEventsController.add(events);
      },
    );
  }

  // イベント（募集応募不問・日時不問）
  void loadJoinEvents() {
    final querySnapshot = FirebaseFirestore.instance
        .collection('event')
        .where('participant', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    querySnapshot.listen(
      (event) {
        final events = event.docs.map((DocumentSnapshot doc) {
          //イベントの情報をここでfirebaseから取得している。
          return Event.fromSnapshot(doc);
        }).toList();

        _allEventsController.add(events);
      },
    );
  }

  // イベント（募集応募不問・未来）
  void loadJoinFutureEvents() {
    final now = DateTime.now().toLocal().toIso8601String();
    final querySnapshot = FirebaseFirestore.instance
        .collection('event')
        .where('participant', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .where('date', isGreaterThanOrEqualTo: now)
        .snapshots();

    querySnapshot.listen(
      (event) {
        final events = event.docs.map((DocumentSnapshot doc) {
          //イベントの情報をここでfirebaseから取得している。
          return Event.fromSnapshot(doc);
        }).toList();

        _allEventsController.add(events);
      },
    );
  }

  // イベント（募集・日時不問）
  void loadHostEvents() {
    final now = DateTime.now().toLocal().toIso8601String();
    final querySnapshot = FirebaseFirestore.instance
        .collection('event')
        .where('participant', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .where('createUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    querySnapshot.listen(
      (event) {
        final events = event.docs.map((DocumentSnapshot doc) {
          //イベントの情報をここでfirebaseから取得している。
          return Event.fromSnapshot(doc);
        }).toList();

        _allEventsController.add(events);
      },
    );
  }

  // イベント（募集・未来）
  void loadHostFurureEvents() {
    final now = DateTime.now().toLocal().toIso8601String();
    final querySnapshot = FirebaseFirestore.instance
        .collection('event')
        .where('participant', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .where('createUserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('date', isGreaterThanOrEqualTo: now)
        .snapshots();

    querySnapshot.listen(
      (event) {
        final events = event.docs.map((DocumentSnapshot doc) {
          //イベントの情報をここでfirebaseから取得している。
          return Event.fromSnapshot(doc);
        }).toList();

        _allEventsController.add(events);
      },
    );
  }

  // イベントを追加するときのプロバイダー.
  // ChangeNotifierを使っていないやつ
  // 今後（11/21）event_add_providerをこのファイルに取り入れたい
  // @override
  // Future<void> addEvent(Event event) {
  //   if (event.name == "") {
  //     throw "名前が入力されていません";
  //   }
  //   if (event.genre == "-") {
  //     throw "ジャンルは、-以外を選択してください";
  //   }
  //   if (event.prefec == "-") {
  //     throw "県は、-以外を選択してください";
  //   }
  //   if (event.place == "") {
  //     throw "場所が入力されていません";
  //   }
  //   if ( event.age == "") {
  //     throw "年齢が入力されていません";
  //   }
  //   if (event.gender == "-") {
  //     throw "性別は、-以外を選択してください";
  //   }
  //   if (event.people == "") {
  //     throw "人数が入力されていません";
  //   }
  //   if (event.background == "") {
  //     throw "募集理由が入力されていません";
  //   }

  //   final events = FirebaseFirestore.instance.collection("event");
  //   return events.add({
  //     "name": event.name,
  //     "date": event.date, //datetime型は、自動でtimestamp型へ
  //     "place": event.place,
  //     "prefec": event.prefec,
  //     "gender": event.gender,
  //     "age": event.age,
  //     "num": event.people,
  //     "genre": event.genre,
  //     "background": event.background,
  //     "startPlace": event.startplace,
  //     "startTime": event.starttime,
  //     "goalPlace": event.goalplace,
  //     "goalTime": event.goaltime
  //   });
  // }
}
