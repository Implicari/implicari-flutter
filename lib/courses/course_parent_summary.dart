import 'package:flutter/material.dart';
import 'package:implicari/courses/course_parent_detail_page.dart';
import 'package:implicari/model/course_model.dart';

class CourseParentSummary extends StatelessWidget {
  final Course course;

  const CourseParentSummary({super.key, required this.course});

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
              const Icon(Icons.escalator_warning),
              const SizedBox(width: 20),
              Text(course.name),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseParentDetailPage(
              id: course.id,
            ),
          ),
        );
      },
    );
  }
}
