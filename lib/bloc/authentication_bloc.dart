import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:implicari/repository/user_repository.dart';
import 'package:implicari/model/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository})
    : super(AuthenticationUnauthenticated()) {

        on<AppStarted>((event, emit) async {
            bool hasToken = await userRepository.hasToken();

            if (hasToken) {
                emit(AuthenticationAuthenticated());
            } else {
                emit(AuthenticationUnauthenticated());
            }
        });

        on<LoggedOut>((event, emit) async {
          emit(AuthenticationLoading());

          await userRepository.logout();

          emit(AuthenticationUnauthenticated());
        });

        on<LoggedIn>((event, emit) async {
            emit(AuthenticationLoading());

            await userRepository.setToken(event.user.token);

            emit(AuthenticationAuthenticated());
        });


      }

}
