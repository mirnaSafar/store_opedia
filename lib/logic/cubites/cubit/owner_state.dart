part of 'owner_cubit.dart';

@immutable
abstract class OwnerState {}

// ignore: must_be_immutable
class OwnerInitial extends OwnerState {
  Owner? owner;
  OwnerInitial(this.owner);
}

class UpdateOwnerInitial extends OwnerState {}

class UpdateOwnerProgress extends OwnerState {}

class UpdateOwnerSucceed extends OwnerState {}

class UpdateOwnerFailed extends OwnerState {
  final String message;
  UpdateOwnerFailed({required this.message});
}

class DeleteOwnerProgress extends OwnerState {}

class DeleteOwnerSucceed extends OwnerState {}

class DeleteOwnerFailed extends OwnerState {
  final String message;
  DeleteOwnerFailed({required this.message});
}
