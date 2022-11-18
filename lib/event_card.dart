import 'package:enpit_weee/event_detail.dart';
import 'package:enpit_weee/model/event_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({required this.event, super.key});

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
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)]),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: imageWidget(),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        event.name,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'NotoSansJP',
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              event.date,
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          // Text(
                          //   event.place,
                          //   style: TextStyle(
                          //     fontSize: 25,
                          //   ),
                          // ),
                          Spacer(
                            flex: 1,
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget imageWidget() {
    return ClipRect(
        child: FittedBox(
      child: Image.asset('assets/eat.png'),
      fit: BoxFit.cover,
    ));
  }
}
