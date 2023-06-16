import 'package:flutter/material.dart';
import 'package:implicari/students/student_detail_page.dart';
import 'package:implicari/model/student_model.dart';

class StudentSummary extends StatelessWidget {
  final Student student;

  const StudentSummary({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentDetailPage(studentId: student.id)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Icon(Icons.child_care),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${student.firstName} ${student.lastName}'),
                      Text(student.run),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
