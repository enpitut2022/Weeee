import 'package:enpit_weee/event_detail.dart';
import 'package:enpit_weee/model/event_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({required this.event});

  Event event;

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetail(event: event),
            ),
          );
        },
        child: Expanded(
          child: Container(
            height: _screenSize.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/eat.png'),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                //const SizedBox(height: 30),
                Text(
                  event.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSansJP',
                  ),
                  overflow: TextOverflow.fade,
                ),
                //const SizedBox(height: 100),
                Text(
                  '場所 :' + event.place,
                  style: TextStyle(fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                ),
                //const SizedBox(height: 4),
                Text(
                  '日時 :' + event.date,
                  style: TextStyle(fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                ),
                //const SizedBox(height: 4),
                Text(
                  event.gender + '性' + event.age.toString() + '歳',
                  style: TextStyle(fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
