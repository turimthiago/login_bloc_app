import 'package:bloc/bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_event.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_state.dart';
import 'package:login_bloc_app/blocs/login/login_event.dart';
import 'package:login_bloc_app/blocs/login/login_state.dart';
import 'package:login_bloc_app/services/authentication_service.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  LoginBloc(
      {required AuthenticationBloc authenticationBloc,
      required AuthenticationService authenticationService})
      : this._authenticationBloc = authenticationBloc,
        this._authenticationService = authenticationService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield LoginLoading();
      try {
        final user = await this
            ._authenticationService
            .signIn(event.email, event.password);
        if (user != null) {
          this._authenticationBloc.add(UserLoggedIn(user: user));
          yield LoginSuccess();
          yield LoginInitial();
        }
      } catch (err) {
        yield LoginFailure(error: 'An unknown error occured');
      }
    }
  }
}
