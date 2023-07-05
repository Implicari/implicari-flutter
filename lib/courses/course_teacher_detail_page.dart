import 'package:implicari/courses/course_edit_page.dart';
import 'package:implicari/events/event_create_page.dart';
import 'package:implicari/events/events_upcoming.dart';
import 'package:flutter/material.dart';
import 'package:implicari/messages/last_messages.dart';
import 'package:implicari/messages/message_create_page.dart';

import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';
import 'package:implicari/students/student_create_page.dart';
import 'package:implicari/students/student_list.dart';

class CourseTeacherDetailPage extends StatefulWidget {
  final int id;

  const CourseTeacherDetailPage({super.key, required this.id});

  @override
  // ignore: no_logic_in_create_state
  State<CourseTeacherDetailPage> createState() => _CourseDetailPage();
}

class _CourseDetailPage extends State<CourseTeacherDetailPage> {
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
            buttonCreate(
              route: MaterialPageRoute(
                builder: (context) => EventCreatePage(courseId: widget.id),
              ),
            ),
            const SizedBox(height: 20),
            LastMessages(courseId: widget.id),
            buttonCreate(
              route: MaterialPageRoute(
                builder: (context) => MessageCreatePage(courseId: widget.id),
              ),
            ),
            const SizedBox(height: 20),
            StudentList(courseId: widget.id),
            buttonCreate(
              route: MaterialPageRoute(
                builder: (context) => StudentCreatePage(courseId: widget.id),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonCreate({required Route route}) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(context, route).then((value) => setState(() {}));
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('crear'),
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
        ],
      ),
    );
  }
}
