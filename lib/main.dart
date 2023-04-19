import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicari/courses/course_list_page.dart';

import 'package:implicari/repository/user_repository.dart';
import 'package:implicari/bloc/authentication_bloc.dart';
import 'package:implicari/splash/splash.dart';
import 'package:implicari/login/login_page.dart';
import 'package:implicari/common/common.dart';

import 'home/home_page.dart';

void main() {
  final userRepository = UserRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        // brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return const SplashPage();
          }

          if (state is AuthenticationAuthenticated) {
            // return const CourseListPage();
            return const HomePage();
          }

          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }
}
