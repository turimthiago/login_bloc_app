import 'package:equatable/equatable.dart';
import 'package:login_bloc_app/models/user.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserLoggedIn extends AuthenticationEvent {
  final User user;

  UserLoggedIn({required this.user});

  @override
  List<Object> get props => [this.user];
}

class UserLoggedOut extends AuthenticationEvent {}
