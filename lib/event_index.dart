import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/event_add.dart';
import 'package:enpit_weee/event_grid.dart';
import 'package:enpit_weee/model/event_model.dart';
import 'package:enpit_weee/provider/event_provider.dart';
import 'package:flutter/material.dart';

class EventIndex extends StatefulWidget {
  const EventIndex({super.key});

  @override
  State<EventIndex> createState() => _EventIndexState();
}

class _EventIndexState extends State<EventIndex> {
  EventProvider _eventProvider = EventProvider();

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
                        final _events = snapshot.data!;
                        return Scaffold(
                          body: Column(
                            children: [
                              Expanded(
                                child: EventGrid(
                                  events: _events,
                                ),
                              ),
                            ],
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
                builder: (context) => EventAddPage(),
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
