import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_event.dart';
import 'package:login_bloc_app/models/user.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, ${user.email}'),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  authBloc.add(UserLoggedOut());
                },
                child: Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
