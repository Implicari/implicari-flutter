import 'package:flutter/material.dart';
import 'package:implicari/model/event_model.dart';
import 'package:implicari/repository/event_repository.dart';

class EventDetailPage extends StatefulWidget {
  final int eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  State<EventDetailPage> createState() => _EventDetailPage();
}

class _EventDetailPage extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    final EventRepository eventRepository = EventRepository();

    Future<Event> getEvent = eventRepository.getEvent(widget.eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de evento'),
      ),
      body: FutureBuilder(
        future: getEvent,
        builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            return EventDetail(event: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class EventDetail extends StatelessWidget {
  final Event event;

  const EventDetail({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month, color: Colors.grey, size: 14),
                      const SizedBox(width: 5),
                      Text(event.date.toString().split(' ')[0]),
                      const SizedBox(width: 20),
                      const Icon(Icons.access_time, color: Colors.grey, size: 14),
                      const SizedBox(width: 5),
                      Text(event.time ?? '--:--'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                child: Text(event.description ?? ''),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
