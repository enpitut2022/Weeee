import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/model/event_model.dart';

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
}
