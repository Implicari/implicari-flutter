import 'package:flutter/material.dart';
import 'package:implicari/students/student_summary.dart';
import 'package:implicari/model/student_model.dart';
import 'package:implicari/repository/student_repository.dart';
import 'package:implicari/widgets/empty_list_feedback.dart';
import 'package:implicari/widgets/error_feedback.dart';

class StudentList extends StatefulWidget {
  final int courseId;

  const StudentList({super.key, required this.courseId});

  @override
  State<StudentList> createState() => _StudentList();
}

class _StudentList extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    final StudentRepository studentRepository = StudentRepository();

    return FutureBuilder<List<Student>>(
      future: studentRepository.getStudents(widget.courseId),
      builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
        Widget body;

        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            body = const EmptyListFeedback(message: 'No hay estudiantes');
          } else {
            body = Column(
              children: snapshot.data!.map((student) => StudentSummary(student: student)).toList(),
            );
          }
        } else if (snapshot.hasError) {
          body = ErrorFeedback(message: snapshot.error.toString());
        } else {
          body = const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Estudiantes',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            body,
          ],
        );
      },
    );
  }
}
