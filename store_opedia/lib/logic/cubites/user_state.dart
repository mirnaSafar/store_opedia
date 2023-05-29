import '../../data/models/user.dart';

abstract class UserAuthState {}

class UserAuthInitialState extends UserAuthState {}

class UserAuthProgress extends UserAuthState {}

class UserAuthLoginedIn extends UserAuthState {
  final User user;
  UserAuthLoginedIn({required this.user});
}

class UserAuthLoginedInSuccessfully extends UserAuthState {}

class UserAuthLoginedInFailed extends UserAuthState {}

class UserAuthSignedUp extends UserAuthState {}

class UserAuthFailed extends UserAuthState {
  final String message;
  UserAuthFailed(this.message);
}

class UserAuthNoToken extends UserAuthState {}
