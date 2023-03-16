import 'package:flutter/material.dart';
import 'package:implicari/model/event_model.dart';
import 'package:intl/intl.dart';

class EventSummary extends StatelessWidget {
  final Event event;

  const EventSummary({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    DateFormat formatMonth = DateFormat('MMM');

    Widget timeWidget = Container();

    if (event.time != null) {
      timeWidget = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.access_time, color: Colors.grey, size: 14),
          const SizedBox(width: 8),
          Text(event.time ?? ''),
        ],
      );
    }

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Text(formatMonth.format(event.date).toUpperCase()),
                    Text(
                      event.date.day.toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text(course.nextEvent.time),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.description),
                    timeWidget,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
