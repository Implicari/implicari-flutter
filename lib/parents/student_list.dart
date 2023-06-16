import 'package:flutter/material.dart';
import 'package:implicari/students/student_create_page.dart';
import 'package:implicari/students/student_summary.dart';
import 'package:implicari/model/student_model.dart';
import 'package:implicari/repository/student_repository.dart';

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
        List<Widget> children;

        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            children = <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                      size: 24,
                    ),
                    SizedBox(width: 16),
                    Text('No hay estudiantes', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
            ];
          } else {
            children = snapshot.data!.map((student) => StudentSummary(student: student)).toList();
          }
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Estudiantes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  ElevatedButton(
                    child: const Text('crear'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentCreatePage(courseId: widget.courseId),
                        ),
                      ).then((value) => setState(() {}));
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: children),
            ),
          ],
        );
      },
    );
  }
}
