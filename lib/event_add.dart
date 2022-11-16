import 'package:enpit_weee/provider/event_add_provider.dart';
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

  String? genderDefo = '男性';

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
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: "イベント名"),
                      onChanged: (text) {
                        model.name = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: "時間"),
                      onChanged: (text) {
                        model.date = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: "場所"),
                      onChanged: (text) {
                        model.place = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // TextField(
                    //   decoration: const InputDecoration(hintText: "あなたの性別"),
                    //   onChanged: (text) {
                    //     model.gender = text;
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    TextField(
                      decoration: const InputDecoration(hintText: "あなたの年齢"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (text) {
                        model.age = int.parse(text); //stringをintへ
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(hintText: "およそ何人で行きたいですか？"),
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
                      decoration:
                          const InputDecoration(hintText: "どのような雰囲気で楽しみたいですか？"),
                      onChanged: (text) {
                        model.atmosphere = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: "参加者へ一言！"),
                      onChanged: (text) {
                        model.greeting = text;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropdownButton(
                      value: genderDefo,
                      onChanged: (String? value) {
                        setState(() {
                          model.gender = value;
                        });
                      },
                      items: const [
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
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await model.addEvent();
                          Navigator.of(context).pop(true);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text("追加する"),
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
