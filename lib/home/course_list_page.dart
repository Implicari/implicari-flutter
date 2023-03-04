import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicari/bloc/authentication_bloc.dart';
import 'package:implicari/home/bloc/courses_bloc.dart';
import 'package:implicari/home/bloc/courses_event.dart';
import 'package:implicari/home/bloc/courses_state.dart';
import 'package:implicari/repository/course_repository.dart';
import 'package:implicari/model/course_model.dart';


class CourseListPage extends StatelessWidget {
    const CourseListPage({ super.key });

    @override
    Widget build(BuildContext context) {
        return MultiBlocProvider(
            providers: [
                BlocProvider<CoursesBloc>(
                    create: (BuildContext context) => CoursesBloc(CourseRepository()),
                ),
                BlocProvider<CoursesParentBloc>(
                    create: (BuildContext context) => CoursesParentBloc(CourseRepository()),
                ),
            ],
            child: createBody(),
        );
    }

    Widget createBody() {
        return BlocProvider(
            create: (context) => CoursesBloc(
                CourseRepository(),
            )..add(LoadCoursesEvent()),
            child: BlocBuilder<CoursesBloc, CoursesState>(
                builder: (context, state) {

                    if (state is CoursesLoadingState) {
                        return const Center(
                            child: CircularProgressIndicator(),
                        );
                    }

                    if (state is CoursesErrorState) {
                        return Center(child: Text(state.error));
                    }

                    if (state is CoursesLoadedState) {
                        List<Course> courses = state.courses;

                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 10, top: 20),
                                        child: Text(
                                            'Profesor',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                        ),
                                    ),

                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: courses.length,
                                        itemBuilder: (_, index) {
                                            return  Card(
                                                color: Theme.of(context).primaryColor,
                                                child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                    child: Text(
                                                        courses[index].name,
                                                        style: const TextStyle(color: Colors.white),
                                                    ),
                                                ),
                                            );
                                        },
                                    ),
                                ],
                            ),
                        );
                    }

                    return Container();
                },
            ),
        );
    }
}
