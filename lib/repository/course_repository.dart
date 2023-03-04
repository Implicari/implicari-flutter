import 'dart:async';

import 'package:implicari/api_connection/api_connection.dart';
import 'package:implicari/model/course_model.dart';


class CourseRepository {
  CourseAPI api = CourseAPI();

  Future<List<Course>> getTeacherCourses() async {
      return await api.getTeacherCourses();
  }

  Future<List<Course>> getParentCourses() async {
      return await api.getParentCourses();
  }
}
