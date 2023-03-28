import 'package:flutter/material.dart';
import 'package:implicari/courses/course_create_page.dart';
import 'package:implicari/courses/course_summary.dart';

import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  final CourseRepository courseRepository = CourseRepository();

  late Future<List<Course>> getTeacherCourses;
  late Future<List<Course>> getParentCourses;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();

    getTeacherCourses = courseRepository.getTeacherCourses();
    getParentCourses = courseRepository.getParentCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          setState(() {
            getTeacherCourses = courseRepository.getTeacherCourses();
            getParentCourses = courseRepository.getParentCourses();
          });
        },
        child: ListView(
          children: [
            FutureBuilder<List<Course>>(
              future: getTeacherCourses,
              builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
                return createBody(context, snapshot, 'Profesor', Icons.co_present);
              },
            ),
            FutureBuilder<List<Course>>(
              future: getParentCourses,
              builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
                return createBody(context, snapshot, 'Apoderado', Icons.escalator_warning);
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('crear curso'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CourseCreatePage(),
                  ),
                ).then((value) => setState(() {
                      getTeacherCourses = courseRepository.getTeacherCourses();
                      getParentCourses = courseRepository.getParentCourses();
                    }));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show refresh indicator programmatically on button tap.
          _refreshIndicatorKey.currentState?.show();
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Show Indicator'),
      ),
    );
  }

  Widget createBody(
      BuildContext context, AsyncSnapshot<List<Course>> snapshot, String title, IconData icon) {
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      List<Course> courses = snapshot.data ?? [];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ...courses.map((course) => CourseSummary(course: course, icon: icon)).toList(),
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
