import 'package:login_bloc_app/models/user.dart';
import 'package:login_bloc_app/services/authentication_service.dart';

class FakeAuthenticationService extends AuthenticationService {
  User? user;

  @override
  Future<User?> getCurrentUser() {
    return Future.delayed(
      Duration(seconds: 5),
      () {
        return user;
      },
    );
  }

  @override
  Future<User?> signIn(String email, String password) {
    return Future.delayed(
      Duration(seconds: 5),
      () {
        return User(email: email, password: password);
      },
    );
  }

  @override
  Future<void> signOut() {
    return Future.delayed(
      Duration(seconds: 5),
      () {
        user = null;
      },
    );
  }
}
