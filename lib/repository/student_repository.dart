import 'dart:async';

import 'package:implicari/model/student_model.dart';
import 'package:implicari/repository/implicari_repository.dart';

class StudentRepository extends ImplicariRepository {
  Future<List<Student>> getStudents(int courseId) async {
    final data = await getAuth('/api/courses/$courseId/students/');
    final List results = data['results'];

    return results.map((e) => Student.fromJson(e)).toList();
  }

  Future<List<Student>> getParentStudents(int courseId) async {
    final data = await getAuth('/api/courses/$courseId/parent-students/');
    final List results = data['results'];

    return results.map((e) => Student.fromJson(e)).toList();
  }

  Future<Student> getStudent(int studentId) async {
    final Map<String, dynamic> data = await getAuth('/api/students/$studentId/');

    return Student.fromJson(data);
  }

  Future<Student> create({
    required int courseId,
    required String firstName,
    required String lastName,
    required String run,
  }) async {
    final Map<String, dynamic> data = await postAuth(
      '/api/courses/$courseId/students/create/',
      {
        'first_name': firstName,
        'last_name': lastName,
        'run': run,
      },
    );

    return Student.fromJson(data);
  }
}
