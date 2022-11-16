import 'package:enpit_weee/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:speech_balloon/speech_balloon.dart';

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
                bottom: const BorderSide(
                  color: Colors.black,
                  width: 5,
                ),
              ),
            ),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                SpeechBalloon(
                  nipLocation: NipLocation.left,
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.white,
                      ),
                      Text(
                        event.greeting,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            event.atmosphere,
          ),
        ],
      ),
    );
  }
}
