import 'package:enpit_weee/src/event/event_card.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/myEvent/my_event_card.dart';
import 'package:enpit_weee/src/provider/event_provider.dart';
import 'package:flutter/material.dart';

class MyJoinEvent extends StatefulWidget {
  const MyJoinEvent({super.key});

  @override
  State<MyJoinEvent> createState() => _MyJoinEventState();
}

class _MyJoinEventState extends State<MyJoinEvent> {
  final EventProvider _eventProvider = EventProvider();

  @override
  void initState() {
    _eventProvider.loadJoinEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('参加するイベント'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  alignment: Alignment.topCenter,
                  //データの表示
                  //11/9時点では、データを2つ以上を表示する方法は、streamBuilderのみ
                  //課題点：listviewの中でしか表示できない。コンストラクタを使っていない。
                  //これから：streambuilderを使わなくてもいい方法
                  child: StreamBuilder<List<Event>>(
                      stream: _eventProvider.allEvents,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Event>> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("エラーが発生しました");
                        }
                        if (!snapshot.hasData) {
                          // データを取得できていない時
                          return const CircularProgressIndicator();
                        }
                        final events = snapshot.data!;
                        return Scaffold(
                          body: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (final event in events)
                                  MyEventCard(event: event),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
