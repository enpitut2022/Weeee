import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/provider/event_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//イベントの入力画面
//firebaseのeventという名前のcollectionにデータを追加
class EventAddPage extends StatefulWidget {
  const EventAddPage({super.key});
  @override
  State<EventAddPage> createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  @override
  void initState() {
    super.initState();
  }

  String? genderDefo = '-';
  String? genreDefo = '-';
  String? prefecDefo = '-';
  DateTime inputDate = DateTime.now();
  TimeOfDay nowTime = TimeOfDay.now();

  // 日付をカレンダーで取得するためのメソッド
  Future _calender(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2023, 12, 31),
    );
    if (date != null) {
      setState(() {
        inputDate = date;
      });
    }
  }

  // 時間を時計で取得するためのメソッド
  Future tellTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 00),
    );
    if (time != null) {
      setState(() {
        nowTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddEventProvider>(
      create: (_) => AddEventProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("イベント入力"),
        ),
        body: Center(
          child: Consumer<AddEventProvider>(
            builder: (context, model, child) {
              return Container(
                color: const Color.fromARGB(0, 113, 182, 238),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    TextField(
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: "イベント名(必須)",
                        hintText: "フェス",
                      ),
                      onChanged: (text) {
                        model.name = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text(
                          "ジャンル",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownButton(
                          value: genreDefo,
                          elevation: 50,
                          items: const [
                            DropdownMenuItem(
                              value: '-',
                              child: Text('-'),
                            ),
                            DropdownMenuItem(
                              value: '音楽',
                              child: Text('音楽'),
                            ),
                            DropdownMenuItem(
                              value: 'スポーツ',
                              child: Text('スポーツ'),
                            ),
                            DropdownMenuItem(
                              value: '映画',
                              child: Text('映画'),
                            ),
                            DropdownMenuItem(
                              value: '芸術',
                              child: Text('芸術'),
                            ),
                            DropdownMenuItem(
                              value: 'ファッション',
                              child: Text('ファッション'),
                            ),
                            DropdownMenuItem(
                              value: '食事',
                              child: Text('食事'),
                            ),
                            DropdownMenuItem(
                              value: 'その他',
                              child: Text('その他'),
                            ),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              genreDefo = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                _calender(context);
                              },
                              child: const Text("日付入力"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "${inputDate.year}年${inputDate.month}月${inputDate.day}日"),
                          ],
                        ),
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                tellTime(context);
                              },
                              child: const Text("時間入力"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("${nowTime.hour}時${nowTime.minute}分"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Text(
                          "県",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownButton(
                          value: prefecDefo,
                          elevation: 50,
                          items: const [
                            DropdownMenuItem(
                              value: '-',
                              child: Text('-'),
                            ),
                            DropdownMenuItem(
                              value: '北海道',
                              child: Text('北海道'),
                            ),
                            DropdownMenuItem(
                              value: '青森県',
                              child: Text('青森県'),
                            ),
                            DropdownMenuItem(
                              value: '岩手県',
                              child: Text('岩手県'),
                            ),
                            DropdownMenuItem(
                              value: '宮城県',
                              child: Text('宮城県'),
                            ),
                            DropdownMenuItem(
                              value: '秋田県',
                              child: Text('秋田県'),
                            ),
                            DropdownMenuItem(
                              value: '山形県	',
                              child: Text('山形県	'),
                            ),
                            DropdownMenuItem(
                              value: '福島県',
                              child: Text('福島県'),
                            ),
                            DropdownMenuItem(
                              value: '茨城県',
                              child: Text('茨城県'),
                            ),
                            DropdownMenuItem(
                              value: '栃木県',
                              child: Text('栃木県'),
                            ),
                            DropdownMenuItem(
                              value: '群馬県',
                              child: Text('群馬県'),
                            ),
                            DropdownMenuItem(
                              value: '埼玉県',
                              child: Text('埼玉県'),
                            ),
                            DropdownMenuItem(
                              value: '千葉県',
                              child: Text('千葉県'),
                            ),
                            DropdownMenuItem(
                              value: '東京都	',
                              child: Text('東京都	'),
                            ),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              prefecDefo = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      maxLength: 10,
                      decoration: const InputDecoration(
                          hintText: "武道館", labelText: "場所(必須)"),
                      onChanged: (text) {
                        model.place = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          labelText: "あなたの年齢(数字のみ、必須）", hintText: "20"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (text) {
                        model.age = int.parse(text); //stringをintへ
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Text(
                          "性別",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownButton(
                          value: genderDefo,
                          onChanged: (String? value) {
                            setState(() {
                              genderDefo = value;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: '-',
                              child: Text('-'),
                            ),
                            DropdownMenuItem(
                              value: '男性',
                              child: Text('男性'),
                            ),
                            DropdownMenuItem(
                              value: '女性',
                              child: Text('女性'),
                            ),
                            DropdownMenuItem(
                              value: 'その他',
                              child: Text('その他'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          labelText: "およそ何人で行きたいですか？（数字のみ、必須）", hintText: "3"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (text) {
                        model.people = int.parse(text);
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: "募集する背景を書いてください(必須)",
                          hintText:
                              "友達と○○のライブに行く予定だったんだけど、\n友達が来れなくなったからチケットが余りました。\nライブは行きたいけど、一人で行く勇気は\nありません。○○のファンの人で一緒に行きませんか？"),
                      onChanged: (text) {
                        model.background = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      maxLength: 10,
                      decoration: const InputDecoration(
                          labelText: "集合場所(必須でない)", hintText: "○○駅前"),
                      onChanged: (text) {
                        model.startplace = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          labelText: "集合時間(必須でない)", hintText: "**時"),
                      onChanged: (text) {
                        model.starttime = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      maxLength: 10,
                      decoration: const InputDecoration(
                          labelText: "解散場所(必須でない)", hintText: "○○駅前"),
                      onChanged: (text) {
                        model.goalplace = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          labelText: "集合時間(必須でない)", hintText: "**時"),
                      onChanged: (text) {
                        model.goaltime = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          model.date = DateTime(
                              inputDate.year,
                              inputDate.month,
                              inputDate.day,
                              nowTime.hour,
                              nowTime.minute); // ここでカレンダーの日付をmodel.dateに代入
                          model.genre = genreDefo;
                          model.gender = genderDefo;
                          model.prefec = prefecDefo;
                          await model.addEvent();

                          final date =
                              DateTime.now().toLocal().toIso8601String();
                          await FirebaseFirestore.instance
                              .collection('chat_room')
                              .doc(model.name)
                              .set({
                            'name': model.name,
                            'createdAt': date,
                          });
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text("募集する"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
