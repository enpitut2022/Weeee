import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:enpit_weee/src/myEvent/myeve_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyEventCard extends StatefulWidget {
  MyEventCard({
    required this.event,
    required this.loggedUser,
    super.key,
  });
  Event event;
  UserModels loggedUser;

  @override
  State<MyEventCard> createState() => _MyEventCardState();
}

class _MyEventCardState extends State<MyEventCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        // MyEventCardは、タップすると質問に回答した人を表示する画面に飛ぶ
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MyEventMenu(
                event: widget.event,
                loggedUser: widget.loggedUser,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 3),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: imageWidget(),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.event.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'NotoSansJP',
                      ),
                    ),
                    Row(
                      children: [
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(
                            "${widget.event.date.month}月${widget.event.date.day}日",
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(
                            widget.event.prefec,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageWidget() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset('assets/images/live.png'),
        ),
      );
  }
}
