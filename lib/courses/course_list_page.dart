import 'package:flutter/material.dart';
import 'package:implicari/courses/course_create_page.dart';
import 'package:implicari/courses/course_parent_summary.dart';
import 'package:implicari/courses/course_teacher_summary.dart';

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
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        setState(() {
          getTeacherCourses = courseRepository.getTeacherCourses();
          getParentCourses = courseRepository.getParentCourses();
        });
      },
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              'Profesor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          FutureBuilder<List<Course>>(
            future: getTeacherCourses,
            builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
              return courseTeacherBuilder(context, snapshot);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              'Apoderado',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          FutureBuilder<List<Course>>(
            future: getParentCourses,
            builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
              return courseParentBuilder(context, snapshot);
            },
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }

  Widget courseTeacherBuilder(BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      List<Course> courses = snapshot.data ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: courses.map((course) => CourseTeacherSummary(course: course)).toList(),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget courseParentBuilder(BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      List<Course> courses = snapshot.data ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: courses
            .map(
              (course) => CourseParentSummary(course: course),
            )
            .toList(),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
