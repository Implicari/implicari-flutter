import 'package:implicari/courses/course_edit_page.dart';
import 'package:implicari/events/events_upcoming.dart';
import 'package:flutter/material.dart';
import 'package:implicari/messages/last_messages.dart';

import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';
import 'package:implicari/students/student_list.dart';

class CourseDetailPage extends StatefulWidget {
  final int id;

  const CourseDetailPage({super.key, required this.id});

  @override
  // ignore: no_logic_in_create_state
  State<CourseDetailPage> createState() => _CourseDetailPage();
}

class _CourseDetailPage extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    final CourseRepository courseRepository = CourseRepository();

    Future<CourseRetrieve> getCourse = courseRepository.getCourse(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de curso'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => CourseEditPage(id: widget.id),
                    ),
                  )
                  .then((value) => setState(() {
                        getCourse = courseRepository.getCourse(widget.id);
                      }));
            },
            child: const Icon(Icons.edit),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, left: 20),
            child: Text(
              'Profe',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder<CourseRetrieve>(
              future: getCourse,
              builder: (BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
                return createBody(context, snapshot);
              },
            ),
          ),
          const SizedBox(height: 20),
          EventsUpcoming(courseId: widget.id),
          const SizedBox(height: 20),
          LastMessages(courseId: widget.id),
          const SizedBox(height: 20),
          StudentList(courseId: widget.id),
        ],
      ),
    );
  }

  Widget createBody(BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
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
