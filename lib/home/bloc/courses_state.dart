import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:implicari/model/course_model.dart';


@immutable
abstract class CoursesState extends Equatable {}

class CoursesLoadingState extends CoursesState {
  @override
  List<Object?> get props => [];
}


class CoursesLoadedState extends CoursesState {
  final List<Course> courses;

  CoursesLoadedState(this.courses);

  @override
  List<Object?> get props => [courses];
}


class CoursesErrorState extends CoursesState {
  final String error;

  CoursesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
