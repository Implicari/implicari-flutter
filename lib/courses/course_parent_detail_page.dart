import 'package:implicari/events/events_upcoming.dart';
import 'package:flutter/material.dart';
import 'package:implicari/messages/last_messages.dart';

import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';
import 'package:implicari/students/student_list.dart';

class CourseParentDetailPage extends StatefulWidget {
  final int id;

  const CourseParentDetailPage({super.key, required this.id});

  @override
  // ignore: no_logic_in_create_state
  State<CourseParentDetailPage> createState() => _CourseParentDetailPage();
}

class _CourseParentDetailPage extends State<CourseParentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final CourseRepository courseRepository = CourseRepository();

    Future<CourseRetrieve> getCourse = courseRepository.getCourse(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apoderado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            FutureBuilder<CourseRetrieve>(
              future: getCourse,
              builder: (BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
                return createBody(context, snapshot);
              },
            ),
            const SizedBox(height: 20),
            EventsUpcoming(courseId: widget.id),
            const SizedBox(height: 20),
            LastMessages(courseId: widget.id),
            const SizedBox(height: 20),
            StudentList(courseId: widget.id),
          ],
        ),
      ),
    );
  }

  Widget createBody(BuildContext context, AsyncSnapshot<CourseRetrieve> snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      CourseRetrieve? course = snapshot.data;

      return CourseSummary(course: course!);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class CourseSummary extends StatelessWidget {
  final CourseRetrieve course;

  const CourseSummary({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
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
                child: Icon(Icons.co_present),
              ),
              Text(course.name),
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.primary),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Icon(Icons.assignment_ind),
              ),
              Text(course.teacher.email),
            ],
          ),
        ],
      ),
    );
  }
}
