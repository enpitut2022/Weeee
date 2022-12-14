import 'package:enpit_weee/src/event/event_card.dart';
import 'package:enpit_weee/src/event/event_add.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/provider/event_provider.dart';
import 'package:flutter/material.dart';

class EventIndex extends StatefulWidget {
  const EventIndex({super.key});

  @override
  State<EventIndex> createState() => _EventIndexState();
}

class _EventIndexState extends State<EventIndex> {
  final EventProvider _eventProvider = EventProvider();

  @override
  void initState() {
    _eventProvider.loadAllEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('イベント一覧画面'),
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
                                  EventCard(event: event),
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EventAddPage(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
