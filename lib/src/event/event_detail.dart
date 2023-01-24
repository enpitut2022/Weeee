import 'package:bubble/bubble.dart';
import 'package:enpit_weee/my_widgets.dart';
import 'package:enpit_weee/src/event/event_quetion.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  EventDetail({
    required this.event,
    required this.loggedUser,
    super.key,
  });
  Event event;
  UserModels loggedUser;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('イベント詳細'),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: myColor("other"),
                  width: 1,
                ),
              ),
            ),
              child: Text(
                widget.event.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            myBoxHeight(myHeight(context) * 0.05),
            categoryText("イベントについて"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myBoxHeight(myHeight(context) * 0.01),
                    infoText("アーティスト名"),
                    infoText("都道府県"),
                    myBoxHeight(myHeight(context) * 0.01),
                    infoText("場所"),
                    myBoxHeight(myHeight(context) * 0.01),
                    infoText("日時"),
                    myBoxHeight(myHeight(context) * 0.01),
                    infoText("同行者の希望人数"),
                  ],
                ),
                myBoxWidth(myWidth(context) * 0.1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoText(widget.event.artist),
                      myBoxHeight(myHeight(context) * 0.01),
                      infoText(widget.event.prefec),
                      myBoxHeight(myHeight(context) * 0.01),
                      infoText(widget.event.place),
                      myBoxHeight(myHeight(context) * 0.01),
                      infoText(
                          "${widget.event.date.year}年${widget.event.date.month}月${widget.event.date.day}日"),
                      myBoxHeight(myHeight(context) * 0.01),
                      infoText("${widget.event.people.toString()} 人"),
                    ],
                  ),
                ),
              ],
            ),
            myBoxHeight(myHeight(context) * 0.05),
            categoryText("募集者について"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoText("性別"),
                    myBoxHeight(myHeight(context) * 0.02),
                    infoText("年齢"),
                    myBoxHeight(myHeight(context) * 0.02),
                    infoText("聴いている期間"),
                    myBoxHeight(myHeight(context) * 0.02),
                    infoText("ライブへの参加回数"),
                  ],
                ),
                myBoxWidth(myWidth(context) * 0.1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoText(widget.event.gender),
                    myBoxHeight(myHeight(context) * 0.02),
                    infoText(widget.event.age.toString()),
                    myBoxHeight(myHeight(context) * 0.02),
                    infoText(widget.event.fanhistory),
                    myBoxHeight(myHeight(context) * 0.02),
                    infoText(widget.event.participation),
                  ],
                ),
              ],
            ),
            myBoxHeight(myHeight(context) * 0.01),
            infoText("募集した理由"),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: myColor("other"),
                  size: myWidth(context)*0.18,
                ),
                Flexible(
                  child: SizedBox(
                    width: myWidth(context)*0.8,
                    child: Bubble(
                      margin: const BubbleEdges.only(top: 10),
                      color: myColor("main1"),
                      nip: BubbleNip.leftCenter,
                      child: Text(
                        widget.event.background,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            myBoxHeight(myHeight(context)*0.1)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (widget.event.createUserID == widget.loggedUser.uid)
          ? Container()
          : FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailQuestion(
                      event: widget.event,
                      loggedUser: widget.loggedUser,
                    ),
                    // fullscreenDialog: true,
                  ),
                );
              },
              label: const Text("応募してみる！"),
              backgroundColor: const Color.fromARGB(255, 255, 82, 70),
            ),
    );
  }

  Widget categoryText(String txt) {
    return Text(
      txt,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Widget infoText(String txt) {
    return Text(
      txt,
      style: const TextStyle(fontSize: 20),
    );
  }
}
