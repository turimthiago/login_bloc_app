import 'package:bloc/bloc.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_event.dart';
import 'package:login_bloc_app/blocs/authentication/authentication_state.dart';
import 'package:login_bloc_app/services/authentication_service.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationService _authenticationService;

  AuthenticationBloc({required AuthenticationService authenticationService})
      : this._authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield AuthenticationLoading();
      try {
        final currentUser = await this._authenticationService.getCurrentUser();
        if (currentUser != null) {
          yield AuthenticationAuthenticated(user: currentUser);
        } else {
          yield AuthenticationNotAuthenticated();
        }
      } catch (e) {
        yield AuthenticationFailure(message: e.toString());
      }
    }
    if (event is UserLoggedIn) {
      yield AuthenticationAuthenticated(user: event.user);
    }
    if (event is UserLoggedOut) {
      yield AuthenticationLoading();
      await this._authenticationService.signOut();
      yield AuthenticationNotAuthenticated();
    }
  }
}
