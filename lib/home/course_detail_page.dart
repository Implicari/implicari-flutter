import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:implicari/model/event_model.dart';

import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';


class CourseDetailPage extends StatelessWidget {

    final int id;
    final String name;

    const CourseDetailPage({ super.key, required this.id, required this.name });

    @override
    Widget build(BuildContext context) {
        final CourseRepository courseRepository = CourseRepository();

        return Scaffold(
          appBar: AppBar(
            title: Text(name),
          ),
          body: Column(
            children: [
                FutureBuilder<CourseRetrieve>(
                    future: courseRepository.getCourse(id),
                    builder: (BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
                        return createBody(context, snapshot, 'Profesor');
                    },
                ),

            ],
          ),
        );
    }

    Widget createBody(BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot, String title) {
        if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
        }

        else if (snapshot.hasData) {

            CourseRetrieve course = snapshot.data ?? CourseRetrieve(id: 0, name: '', nextEvent: Event(description: '', id: 0));
            DateFormat formatMonth = DateFormat('MMM');

            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 20),
                            child: Text(
                                'Próximo evento',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                            ),
                        ),
                        Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        child: Column(
                                          children: [
                                            Text(formatMonth.format(course.nextEvent.date).toUpperCase()),
                                            Text(
                                              course.nextEvent.date.day.toString(),
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // Text(course.nextEvent.time),
                                          ],
                                        ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(course.nextEvent.description),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.access_time, color: Colors.grey, size: 14),
                                            const SizedBox(width: 8),
                                            Text(course.nextEvent.time),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                                            ],
                ),
            );
        }
        else {
            return const Center(
                child: CircularProgressIndicator(),
            );
        }

    }
}
