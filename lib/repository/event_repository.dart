import 'dart:async';

import 'package:implicari/model/event_model.dart';
import 'package:implicari/repository/implicari_repository.dart';

class EventRepository extends ImplicariRepository {
  Future<List<Event>> getEvents(int courseId) async {
    final data = await getAuth('/api/courses/$courseId/events/');
    final List results = data['results'];

    return results.map((e) => Event.fromJson(e)).toList();
  }

  Future<List<Event>> getEventsUpcoming(int courseId) async {
    final data = await getAuth('/api/courses/$courseId/events/upcoming/');
    final List results = data['results'];

    return results.map((e) => Event.fromJson(e)).toList();
  }

  Future<Event> getEvent(int courseId, int eventId) async {
    final Map<String, dynamic> data =
        await getAuth('/api/courses/$courseId/events/$eventId');

    return Event.fromJson(data);
  }
}