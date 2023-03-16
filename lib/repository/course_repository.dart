import 'dart:async';

import 'package:implicari/model/course_model.dart';
import 'package:implicari/repository/implicari_repository.dart';

class CourseRepository extends ImplicariRepository {

  Future<List<Course>> getTeacherCourses() async {
    final data = await getAuth('/api/courses/teacher/');
    final List results = data['results'];

    return results.map((e) => Course.fromJson(e)).toList();
  }

  Future<List<Course>> getParentCourses() async {
    final data = await getAuth('/api/courses/parent/');
    final List results = data['results'];

    return results.map((e) => Course.fromJson(e)).toList();
  }

  Future<CourseRetrieve> getCourse(int id) async {
    final Map<String, dynamic> data = await getAuth('/api/courses/$id/');

    return CourseRetrieve.fromJson(data);
  }

  Future<CourseRetrieve> createCourse(String name) async {

    final Map<String, dynamic> data = await postAuth('/api/courses/create/', {'name': name});

    return CourseRetrieve.fromJson(data);

  }
}
