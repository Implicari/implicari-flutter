import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


@immutable
abstract class CoursesEvent extends Equatable {
  const CoursesEvent();
}

class LoadCoursesEvent extends CoursesEvent {
  @override
  List<Object?> get props => [];
}
