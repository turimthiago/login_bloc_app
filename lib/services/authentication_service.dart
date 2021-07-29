import 'package:login_bloc_app/models/user.dart';

abstract class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<void> signOut();
  Future<User?> signIn(String email, String password);
}
