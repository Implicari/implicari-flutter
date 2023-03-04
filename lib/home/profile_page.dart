import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicari/bloc/authentication_bloc.dart';


class ProfilePage extends StatelessWidget {
    const ProfilePage({ super.key });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Expanded(child: Container()),
                    const Expanded(
                        child: Icon(Icons.tag_faces, size: 100, color: Colors.black12),
                    ),
                    Expanded(child: Container()),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                child: const Text(
                                    'Cerrar sesión',
                                    style: TextStyle(fontSize: 24),
                                ),
                                onPressed: () {
                                    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                                },
                            ),
                        ),
                    ),
                    Expanded(child: Container()),
                ],
            ),
        );
    }

}
