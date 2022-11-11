import 'package:enpit_weee/model/event_model.dart';
import 'package:flutter/material.dart';


class EventDetail extends StatelessWidget {
  EventDetail({required this.event});
  Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント詳細'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment(0.0, 0),
            //color: Colors.blue,
            height: 80,
            width: 500,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: const Border(
                    bottom: const BorderSide(color: Colors.black, width: 5,),),),
            child: Text(
              event.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
          ),
          Text(
            event.place,
          ),
          Text(
            event.date,
          ),
          Text(
            event.gender,
          ),
          Text(
            event.age.toString(),
          ),
          Text(
            event.people.toString(),
          ),

          Container(
            margin: const EdgeInsets.only(left: 15.0),
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Text(event.greeting),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
          ),
          Text(
            event.greeting,
          ),
          Text(
            event.atmosphere,
          ),
        ],
      ),
    );
  }
}
