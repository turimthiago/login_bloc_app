import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_bloc.dart';
import 'package:login_bloc_app/blocs/login/login_bloc.dart';
import 'package:login_bloc_app/blocs/login/login_event.dart';
import 'package:login_bloc_app/blocs/login/login_state.dart';
import 'package:login_bloc_app/services/authentication_service.dart';

class LoginPage extends StatelessWidget {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationBloc: authBloc,
            authenticationService: authService,
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {},
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: state is LoginLoading
                                      ? null
                                      : () {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(
                                                  LoginInWithEmailButtonPressed(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ));
                                        },
                                  child: Text(
                                    'Logar',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
