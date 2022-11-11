import 'package:enpit_weee/event_card.dart';
import 'package:enpit_weee/model/event_model.dart';
import 'package:flutter/material.dart';

class EventGrid extends StatelessWidget {
  final List<Event> _events;
  EventGrid({
    required List<Event> events,
  }) : _events = events;

  

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 5.0,
      children: _events
          .map(
            (event) => EventCard(event: event),
          )
          .toList(),
    );
  }
}
