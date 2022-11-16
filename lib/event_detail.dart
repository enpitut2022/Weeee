import 'package:enpit_weee/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:speech_balloon/speech_balloon.dart';

class EventDetail extends StatelessWidget {
  EventDetail({required this.event});
  Event event;

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('イベント詳細'),
      ),
      body: Column(
        children: [
          Container(
            //color: const Color.fromARGB(255, 201, 198, 243),
            alignment: Alignment(0.0, 0),
            //color: Colors.blue,
            height: 80,
            width: 500,
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 5,
                ),
              ),
            ),
            child: Text(
              event.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _screenSize.height * 0.01,
              ),
              Text(
                "場所　： " + event.place,
                style: const TextStyle(
                  fontSize: 30
                ),
              ),
              SizedBox(
                height: _screenSize.height * 0.01,
              ),
              Text(
                "日時　：" + event.date,
                style: const TextStyle(
                  fontSize: 30
                ),
              ),
              // SizedBox(
              //   height: _screenSize.height * 0.1,
              // ),
              Row(
                children: [
                  Text(
                    event.gender,
                  ),
                  SizedBox(
                    width: _screenSize.width * 0.01,
                  ),
                  Text(
                    event.age.toString(),
                  ),
                  // SizedBox(
                  //   width: _screenSize.width * 0.01,
                  // ),
                  Text(
                    event.people.toString(),
                  ),
                ],
              ),
            ],
          ),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const SizedBox(height: 50),
          //       SpeechBalloon(
          //         nipLocation: NipLocation.left,
          //         color: Colors.green,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             const Icon(
          //               Icons.people,
          //               color: Colors.white,
          //             ),
          //             Text(
          //               event.greeting,
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Text(
          //   event.atmosphere,
          // ),
        ],
      ),
    );
  }
}
