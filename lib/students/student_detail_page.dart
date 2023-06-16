import 'package:flutter/material.dart';
import 'package:implicari/model/student_model.dart';
import 'package:implicari/parents/parent_list.dart';
import 'package:implicari/repository/student_repository.dart';

class StudentDetailPage extends StatefulWidget {
  final int studentId;

  const StudentDetailPage({super.key, required this.studentId});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPage();
}

class _StudentDetailPage extends State<StudentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final StudentRepository studentRepository = StudentRepository();

    Future<Student> getStudent = studentRepository.getStudent(widget.studentId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de estudiante'),
      ),
      body: FutureBuilder(
        future: getStudent,
        builder: (BuildContext context, AsyncSnapshot<Student> snapshot) {
          if (snapshot.hasData) {
            return StudentDetail(student: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class StudentDetail extends StatelessWidget {
  final Student student;

  const StudentDetail({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nombre completo'),
                  Text(
                    '${student.firstName} ${student.lastName}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('RUN'),
                  Text(
                    student.run,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        ParentList(studentId: student.id),
      ],
    );
  }
}
