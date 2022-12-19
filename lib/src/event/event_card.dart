import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enpit_weee/src/event/event_detail.dart';
import 'package:enpit_weee/src/model/event_model.dart';
import 'package:enpit_weee/src/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  EventCard({required this.event, super.key});
  //event モデルの宣言
  Event event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  // user modelsの宣言
  User? user = FirebaseAuth.instance.currentUser;

  UserModals loggedUser = UserModals();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedUser = UserModals.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetail(event: widget.event),
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
                        Expanded(
                          flex: 4,
                          child: Text(
                            "${widget.event.gender}  ${widget.event.age} 歳",
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
    if (widget.event.genre.toString() == 'スポーツ') {
      return ClipRect(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset('assets/images/sport.png'),
        ),
      );
    } else {
      return ClipRect(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset('assets/images/festival.png'),
        ),
      );
    }
  }
}
