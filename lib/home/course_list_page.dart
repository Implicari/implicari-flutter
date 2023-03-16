import 'package:flutter/material.dart';
import 'package:implicari/courses/course_create_page.dart';
import 'package:implicari/home/course_detail_page.dart';

import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseRepository courseRepository = CourseRepository();

    return Column(
      children: [
        FutureBuilder<List<Course>>(
          future: courseRepository.getTeacherCourses(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
            return createBody(context, snapshot, 'Profesor', Icons.co_present);
          },
        ),
        FutureBuilder<List<Course>>(
          future: courseRepository.getParentCourses(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
            return createBody(
                context, snapshot, 'Apoderado', Icons.escalator_warning);
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
            );
          },
        ),
      ],
    );
  }

  Widget createBody(BuildContext context, AsyncSnapshot<List<Course>> snapshot,
      String title, IconData icon) {
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(icon),
                          const SizedBox(width: 20),
                          Text(courses[index].name),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailPage(
                          id: courses[index].id,
                          name: courses[index].name,
                        ),
                      ),
                    );
                  },
                );
              },
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
