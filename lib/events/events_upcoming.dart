import 'package:flutter/material.dart';
import 'package:implicari/events/event_summary.dart';
import 'package:implicari/model/event_model.dart';
import 'package:implicari/repository/event_repository.dart';

class EventsUpcoming extends StatelessWidget {
  final int courseId;

  const EventsUpcoming({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final EventRepository eventRepository = EventRepository();

    return FutureBuilder<List<Event>>(
      future: eventRepository.getEventsUpcoming(courseId),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        List<Widget> children;

        if (snapshot.hasData && snapshot.data != null) {
          children = snapshot.data!
              .map((event) => EventSummary(event: event))
              .toList();
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                'Próximo evento',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Column(children: children),
          ],
        );
      },
    );
  }
}
