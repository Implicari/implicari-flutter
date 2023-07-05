import 'package:flutter/material.dart';
import 'package:implicari/events/event_summary.dart';
import 'package:implicari/model/event_model.dart';
import 'package:implicari/repository/event_repository.dart';

class EventsUpcoming extends StatefulWidget {
  final int courseId;

  const EventsUpcoming({super.key, required this.courseId});

  @override
  State<EventsUpcoming> createState() => _EventsUpcoming();
}

class _EventsUpcoming extends State<EventsUpcoming> {
  @override
  Widget build(BuildContext context) {
    final EventRepository eventRepository = EventRepository();

    return FutureBuilder<List<Event>>(
      future: eventRepository.getEventsUpcoming(widget.courseId),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        List<Widget> children;

        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            children = <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                      size: 24,
                    ),
                    SizedBox(width: 16),
                    Text('No hay eventos', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ];
          } else {
            children = snapshot.data!.map((event) => EventSummary(event: event)).toList();
          }
          // children = snapshot.data!.map((event) => EventSummary(event: event)).toList();
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
            const Text(
              'Próximo evento',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Column(children: children),
          ],
        );
      },
    );
  }
}
