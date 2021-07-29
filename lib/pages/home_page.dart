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
      color: Colors.blue,
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    user.email,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
                  ),
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
          )
        ],
      ),
    ));
  }
}
