part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {
  User? user;
  UserInitial(this.user);
}

class DeleteUserProgress extends UserState {}

class DeleteUserSucceed extends UserState {}

class DeleteUserFailed extends UserState {
  final String message;
  DeleteUserFailed({required this.message});
}

class UpdateUserProgress extends UserState {}

class UpdateUserSucceed extends UserState {}

class UpdateUserFailed extends UserState {
  final String message;
  UpdateUserFailed({required this.message});
}
