import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicari/home/bloc/courses_event.dart';
import 'package:implicari/home/bloc/courses_state.dart';
import 'package:implicari/repository/course_repository.dart';


class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CourseRepository _courseRepository;

  CoursesBloc(this._courseRepository) : super(CoursesLoadingState()) {
    on<LoadCoursesEvent>((event, emit) async {
      emit(CoursesLoadingState());

      try {
        final users = await _courseRepository.getTeacherCourses();
        emit(CoursesLoadedState(users));
      } catch (e) {
        emit(CoursesErrorState(e.toString()));
      }
    });
  }
}


class CoursesParentBloc extends Bloc<CoursesEvent, CoursesState> {
  final CourseRepository _courseRepository;

  CoursesParentBloc(this._courseRepository) : super(CoursesLoadingState()) {
    on<LoadCoursesEvent>((event, emit) async {
      emit(CoursesLoadingState());

      try {
        final users = await _courseRepository.getParentCourses();
        emit(CoursesLoadedState(users));
      } catch (e) {
        emit(CoursesErrorState(e.toString()));
      }
    });
  }
}
