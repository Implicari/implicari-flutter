import 'package:flutter/material.dart';
import 'package:implicari/courses/course_detail_page.dart';
import 'package:implicari/model/course_model.dart';

class CourseSummary extends StatelessWidget {
  final Course course;
  final IconData icon;

  const CourseSummary({super.key, required this.course, required this.icon});

  @override
  Widget build(BuildContext context) {
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
              Text(course.name),
              Text(course.id.toString()),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailPage(
              id: course.id,
            ),
          ),
        );
      },
    );
  }
}
