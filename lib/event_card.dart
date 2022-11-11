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
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/eat.png'))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 30),
                  Expanded(
                    child: Text(
                      event.name,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Text(
                    '場所 :' + event.place,
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '日時 :' + event.date,
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.gender + '性' + event.age.toString() + '歳',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            )

            // child: InkWell(
            //   onTap: () {},
            //   child: Column(
            //     mainAxisSize: MainAxisSize.max,
            //     children: <Widget>[
            //       //名前
            //       Text(
            //         event.name,
            //       ),
            //       //場所
            //       Expanded(
            //         child: Text(
            //           event.place,
            //         ),
            //       ),
            //       Expanded(
            //         child: Text(
            //           event.date,
            //         ),
            //       ),
            //       Expanded(
            //         child: Text(
            //           event.gender,
            //         ),
            //       ),
            //       Expanded(
            //         child: Text(
            //           event.age.toString(),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ));
  }
}
