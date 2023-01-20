import 'package:enpit_weee/my_widgets.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:enpit_weee/src/provider/event_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//イベントの入力画面
//firebaseのeventという名前のcollectionにデータを追加
class EventAddPage extends StatefulWidget {
  EventAddPage({
    required this.loggedUser,
    super.key,
  });
  UserModels loggedUser;
  @override
  State<EventAddPage> createState() => _EventAddPageState();
}

class _EventAddPageState extends State<EventAddPage> {
  @override
  void initState() {
    super.initState();
  }

  String? genderDefo = '-';
  String? genreDefo = 'ライブ/フェス';
  String? prefecDefo = '-';
  String? howmanyDefo = '半年前';
  String? howManyLiveDefo = "初めて";
  int? memberDefo = 2;
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
        appBar: myAppBar('イベント作成'),
        body: Center(
          child: Consumer<AddEventProvider>(
            builder: (context, model, child) {
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    categoryText("イベントについて"),
                    myBoxHeight(5),
                    eventName(model, "イベント名*", "○○の全国ツアー"),
                    myBoxHeight(16),
                    // Row(
                    //   children: [
                    //     const Text(
                    //       "ジャンル",
                    //       style: TextStyle(fontSize: 20),
                    //     ),
                    //     const SizedBox(
                    //       width: 30,
                    //     ),
                    //     DropdownButton(
                    //       value: genreDefo,
                    //       elevation: 50,
                    //       items: const [
                    //         DropdownMenuItem(
                    //           value: '-',
                    //           child: Text('-'),
                    //         ),
                    //         DropdownMenuItem(
                    //           value: 'スポーツ',
                    //           child: Text('スポーツ'),
                    //         ),
                    //         DropdownMenuItem(
                    //           value: 'ライブ/フェス',
                    //           child: Text('ライブ/フェス'),
                    //         ),
                    //       ],
                    //       onChanged: (String? value) {
                    //         setState(() {
                    //           genreDefo = value;
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),
                    //myBoxHeight(16),
                    SizedBox(
                      height: myHeight(context) * 0.1,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    _calender(context);
                                  },
                                  child: Text(
                                    "日付入力",
                                    style: TextStyle(color: myColor("main1")),
                                  ),
                                ),
                                myBoxHeight(10),
                                Text(
                                  "${inputDate.year}年${inputDate.month}月${inputDate.day}日",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            myBoxWidth(myWidth(context) * 0.2),
                            Column(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    tellTime(context);
                                  },
                                  child: Text(
                                    "時間入力",
                                    style: TextStyle(color: myColor("main1")),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${nowTime.hour}時${nowTime.minute}分",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    myBoxHeight(16),
                    prefec(),
                    myBoxHeight(16),
                    eventPlace(model, "開催場所*", "武道館"),
                    myBoxHeight(16),
                    member(),
                    myBoxHeight(40),
                    categoryText("あなたについて"),
                    myBoxHeight(10),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 200,
                      decoration: const InputDecoration(
                        labelText: "募集する背景*",
                        hintText:
                            "友達と○○のライブに行く予定だったんだけど、\n友達が来れなくなったからチケットが余りました。\nライブは行きたいけど、一人で行く勇気は\nありません。○○のファンの人で一緒に行きませんか？",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        model.background = text;
                      },
                    ),
                    myBoxHeight(16),
                    howlong(),
                    myBoxHeight(16),
                    howManyLive(),
                    myBoxHeight(40),
                    categoryText("同行者への質問"),
                    myBoxHeight(10),
                    eventQ1(model, "同行者へのに質問①", "何の曲が好きですか？"),
                    myBoxHeight(16),
                    eventQ2(model, "同行者へのに質問②", "聴き始めたきっかけは何ですか？"),
                    myBoxHeight(16),
                    eventQ3(model, "同行者へのに質問③", "ライブ何回行ったことありますか？"),
                    myBoxHeight(16),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          model.date = DateTime(
                            inputDate.year,
                            inputDate.month,
                            inputDate.day,
                            nowTime.hour,
                            nowTime.minute,
                          ); // ここでカレンダーの日付をmodel.dateに代入
                          model.createUserId = widget.loggedUser.uid;
                          model.createUserName = widget.loggedUser.name;
                          model.gender = widget.loggedUser.gender;
                          model.age = widget.loggedUser.old;
                          model.prefec = prefecDefo;
                          model.fanhistory = howmanyDefo;
                          model.genre = genreDefo;
                          model.people = memberDefo;
                          model.participation = howManyLiveDefo;
                          // model.ans1 = "";
                          // model.ans2 = "";
                          // model.ans3 = "";
                          print(model.name);
                          await model.addEvent();

                          Navigator.of(context).pop(true);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: myColor("red"),
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              myColor("main1"))),
                      child: const Text("イベント作成"),
                    ),
                    myBoxHeight(16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget categoryText(String txt) {
    return Text(
      txt,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget eventName(AddEventProvider model, String label, String hint) {
    return TextField(
      maxLength: 20,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) {
        model.name = text;
      },
    );
  }

  Widget eventPlace(AddEventProvider model, String label, String hint) {
    return TextField(
      maxLength: 20,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) {
        model.place = text;
      },
    );
  }

  Widget eventQ1(AddEventProvider model, String label, String hint) {
    return TextField(
      maxLength: 20,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) {
        model.question1 = text;
      },
    );
  }

  Widget eventQ2(AddEventProvider model, String label, String hint) {
    return TextField(
      maxLength: 20,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) {
        model.question2 = text;
      },
    );
  }

  Widget eventQ3(AddEventProvider model, String label, String hint) {
    return TextField(
      maxLength: 20,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) {
        model.question3 = text;
      },
    );
  }

  Widget member() {
    return Row(
      children: [
        const Text(
          "自分も含めた参加人数",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 30,
        ),
        DropdownButton(
          value: memberDefo,
          elevation: 50,
          items: const [
            DropdownMenuItem(
              value: 2,
              child: Text('2人'),
            ),
            DropdownMenuItem(
              value: 3,
              child: Text('3人'),
            ),
            DropdownMenuItem(
              value: 4,
              child: Text('4人'),
            ),
            DropdownMenuItem(
              value: 5,
              child: Text('5人'),
            ),
            DropdownMenuItem(
              value: 6,
              child: Text('6人'),
            ),
            DropdownMenuItem(
              value: 7,
              child: Text('7人'),
            ),
            DropdownMenuItem(
              value: 8,
              child: Text('8人'),
            ),
          ],
          onChanged: (int? value) {
            setState(() {
              memberDefo = value;
            });
          },
        ),
      ],
    );
  }

  Widget howlong() {
    return Row(
      children: [
        const Text(
          "聴いている期間",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 30,
        ),
        DropdownButton(
          value: howmanyDefo,
          elevation: 50,
          items: const [
            DropdownMenuItem(
              value: '半年前',
              child: Text('半年前'),
            ),
            DropdownMenuItem(
              value: '１年前',
              child: Text('１年前'),
            ),
            DropdownMenuItem(
              value: '２年前',
              child: Text('２年前から'),
            ),
            DropdownMenuItem(
              value: '3年から5年前',
              child: Text('3年から5年前'),
            ),
            DropdownMenuItem(
              value: '5年以上前',
              child: Text('5年以上前'),
            ),
          ],
          onChanged: (String? value) {
            setState(() {
              howmanyDefo = value;
            });
          },
        ),
      ],
    );
  }

  Widget howManyLive() {
    return Row(
      children: [
        const Text(
          "ライブへの参加回数",
          style: TextStyle(fontSize: 20),
        ),
        myBoxWidth(30),
        DropdownButton(
          value: howManyLiveDefo,
          elevation: 50,
          items: const [
            DropdownMenuItem(
              value: '初めて',
              child: Text('初めて'),
            ),
            DropdownMenuItem(
              value: '１回',
              child: Text('１回'),
            ),
            DropdownMenuItem(
              value: '２回',
              child: Text('2回'),
            ),
            DropdownMenuItem(
              value: '3回から5回',
              child: Text('3回から5回'),
            ),
            DropdownMenuItem(
              value: '５回以上',
              child: Text('５回以上'),
            ),
          ],
          onChanged: (String? value) {
            setState(() {
              howManyLiveDefo = value;
            });
          },
        ),
      ],
    );
  }

  Widget prefec() {
    return Row(
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
            DropdownMenuItem(
              value: '神奈川県',
              child: Text('神奈川県'),
            ),
            DropdownMenuItem(
              value: '新潟県',
              child: Text('新潟県'),
            ),
            DropdownMenuItem(
              value: '富山県',
              child: Text('富山県'),
            ),
            DropdownMenuItem(
              value: '石川県',
              child: Text('石川県'),
            ),
            DropdownMenuItem(
              value: '福井県',
              child: Text('福井県'),
            ),
            DropdownMenuItem(
              value: '山梨県	',
              child: Text('山梨県	'),
            ),
            DropdownMenuItem(
              value: '長野県',
              child: Text('長野県'),
            ),
            DropdownMenuItem(
              value: '愛知県',
              child: Text('愛知県'),
            ),
            DropdownMenuItem(
              value: '三重県',
              child: Text('三重県'),
            ),
            DropdownMenuItem(
              value: '滋賀県',
              child: Text('滋賀県'),
            ),
            DropdownMenuItem(
              value: '京都府',
              child: Text('京都府'),
            ),
            DropdownMenuItem(
              value: '大阪府',
              child: Text('大阪府'),
            ),
            DropdownMenuItem(
              value: '兵庫県	',
              child: Text('兵庫県'),
            ),
            DropdownMenuItem(
              value: '奈良県',
              child: Text('奈良県'),
            ),
            DropdownMenuItem(
              value: '和歌山県',
              child: Text('和歌山県'),
            ),
            DropdownMenuItem(
              value: '鳥取県',
              child: Text('鳥取県'),
            ),
            DropdownMenuItem(
              value: '島根県	',
              child: Text('島根県	'),
            ),
            DropdownMenuItem(
              value: '岡山県',
              child: Text('岡山県'),
            ),
            DropdownMenuItem(
              value: '広島県',
              child: Text('広島県'),
            ),
            DropdownMenuItem(
              value: '山口県',
              child: Text('山口県'),
            ),
            DropdownMenuItem(
              value: '徳島県',
              child: Text('徳島県'),
            ),
            DropdownMenuItem(
              value: '香川県',
              child: Text('香川県'),
            ),
            DropdownMenuItem(
              value: '愛媛県',
              child: Text('愛媛県'),
            ),
            DropdownMenuItem(
              value: '高知県	',
              child: Text('高知県'),
            ),
            DropdownMenuItem(
              value: '福岡県',
              child: Text('福岡県'),
            ),
            DropdownMenuItem(
              value: '佐賀県',
              child: Text('佐賀県'),
            ),
            DropdownMenuItem(
              value: '長崎県',
              child: Text('長崎県'),
            ),
            DropdownMenuItem(
              value: '熊本県',
              child: Text('熊本県'),
            ),
            DropdownMenuItem(
              value: '大分県',
              child: Text('大分県'),
            ),
            DropdownMenuItem(
              value: '宮崎県',
              child: Text('宮崎県'),
            ),
            DropdownMenuItem(
              value: '鹿児島県	',
              child: Text('鹿児島県'),
            ),
            DropdownMenuItem(
              value: '沖縄県	',
              child: Text('沖縄県'),
            ),
          ],
          onChanged: (String? value) {
            setState(() {
              prefecDefo = value;
            });
          },
        ),
      ],
    );
  }
}
