import 'package:implicari/events/events_upcoming.dart';
import 'package:flutter/material.dart';
import 'package:implicari/messages/last_messages.dart';

import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';

class CourseDetailPage extends StatelessWidget {
  final int id;
  final String name;

  const CourseDetailPage({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    final CourseRepository courseRepository = CourseRepository();

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: const Text(
              'Profe',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          FutureBuilder<CourseRetrieve>(
            future: courseRepository.getCourse(id),
            builder:
                (BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
              return createBody(context, snapshot);
            },
          ),
          EventsUpcoming(courseId: id),
          LastMessages(courseId: id),
        ],
      ),
    );
  }

  Widget createBody(
      BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      CourseRetrieve? course = snapshot.data;

      return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Icon(Icons.assignment_ind),
                ),
                Text(course!.name),
              ],
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
