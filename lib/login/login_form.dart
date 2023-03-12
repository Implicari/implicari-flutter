import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicari/login/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController =
      TextEditingController(text: 'edna.krabappel@implicari.localhost');
  final _passwordController = TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    handleLogin() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        email: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'email',
                      icon: Icon(Icons.mail),
                    ),
                    controller: _usernameController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'password',
                      icon: Icon(Icons.security),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.width * 0.22,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: state is! LoginLoading ? handleLogin : null,
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: state is LoginLoading
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
