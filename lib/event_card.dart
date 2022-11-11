import 'package:enpit_weee/event_detail.dart';
import 'package:enpit_weee/model/event_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({required this.event});

  Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetail(event: event),
            ),
          );
        },
        child: Container(
          height: 250,
          child: Column(
            children: <Widget>[
              //写真の下
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      //名前
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            event.name,
                          ),
                        ),
                        //場所
                        Expanded(
                          child: Text(
                            event.place,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            event.people.toString(),
                          ),
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
}
