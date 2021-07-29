import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_event.dart';
import 'package:login_bloc_app/pages/home_page.dart';
import 'package:login_bloc_app/pages/main_page.dart';
import 'package:login_bloc_app/services/authentication_service.dart';
import 'package:login_bloc_app/services/impl/fake_authentication_service.dart';

import 'blocs/authentication/authentication_state.dart';

void main() {
  runApp(
    RepositoryProvider<AuthenticationService>(
      create: (context) {
        return FakeAuthenticationService();
      },
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final authService =
              RepositoryProvider.of<AuthenticationService>(context);

          return AuthenticationBloc(
            authenticationService: authService,
          )..add(
              AppLoaded(),
            );
        },
        child: AppWidget(),
      ),
    ),
  );
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Authentication Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return HomePage(
                user: state.user,
              );
            }
            return MainPage();
          },
        ));
  }
}
