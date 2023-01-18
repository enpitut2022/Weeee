import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/myEvent/myeve_card.dart';
import 'package:enpit_weee/src/provider/event_provider.dart';
import 'package:flutter/material.dart';

class MyEventIndex extends StatefulWidget {
  const MyEventIndex({super.key});

  @override
  State<MyEventIndex> createState() => _MyEventIndexState();
}

class _MyEventIndexState extends State<MyEventIndex> {
  final EventProvider _eventProvider = EventProvider();
  bool btn1 = false;
  bool btn2 = false;

  @override
  void initState() {
    // ここでどんなイベントを表示するか決めている
    // 募集参加不問かつ終了不問、募集参加不問終了、募集かつ終了不問、募集かつ未来
    (btn1 == false)
        ? {
            (btn2 == false)
                ? _eventProvider.loadJoinEvents()
                : _eventProvider.loadJoinFutureEvents()
          }
        : {
            (btn2 == false)
                ? _eventProvider.loadHostEvents()
                : _eventProvider.loadHostFurureEvents()
          };
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
              Row(
                children: [
                  const Text("募集したイベント"),
                  Switch(
                    value: btn1,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          btn1 = value;
                          (btn1 == false)
                              ? {
                                  (btn2 == false)
                                      ? _eventProvider.loadJoinEvents()
                                      : _eventProvider.loadJoinFutureEvents()
                                }
                              : {
                                  (btn2 == false)
                                      ? _eventProvider.loadHostEvents()
                                      : btn2=false/*_eventProvider.loadHostFurureEvents()*/
                                };
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("これからのイベント"),
                  Switch(
                    value: btn2,
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          btn2 = value;
                          (btn1 == false)
                              ? {
                                  (btn2 == false)
                                      ? _eventProvider.loadJoinEvents()
                                      : _eventProvider.loadJoinFutureEvents()
                                }
                              : {
                                  (btn2 == false)
                                      ? _eventProvider.loadHostEvents()
                                      : btn1=false/* _eventProvider.loadHostFurureEvents()*/
                                };
                        });
                      }
                    },
                  ),
                ],
              ),
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
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
