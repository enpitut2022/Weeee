import 'package:enpit_weee/src/myEvent/my_join_event.dart';
import 'package:enpit_weee/src/profile/my_join_event.dart';
import 'package:flutter/material.dart';

class MyEventHome extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  const MyEventHome({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var hen = screenSize.height * 0.35;
    double? fs = 35;
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイイベント'),
      ),
      body: SizedBox(
        width: screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: hen,
              width: hen,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: (() async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyJoinEvent()));
                }),
                child:  Text("開始前",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: fs,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: hen,
              width: hen,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: (() {}),
                child:  Text("終了",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: fs,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
