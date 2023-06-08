import 'package:shopesapp/data/models/owner.dart';
import 'package:shopesapp/data/models/user.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthProgress extends AuthState {}

class UserLoginedIn extends AuthState {
  final User user;
  UserLoginedIn({required this.user});
}

class OwnerLoginedIn extends AuthState {
  final Owner owner;
  OwnerLoginedIn({required this.owner});
}

class UserSignedUp extends AuthState {}

class OwnerSignedUp extends AuthState {}

class AuthFailed extends AuthState {
  final String message;
  AuthFailed(this.message);
}

class AuthNoToken extends AuthState {}
