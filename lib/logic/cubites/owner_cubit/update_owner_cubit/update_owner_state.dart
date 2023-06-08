part of 'update_owner_cubit.dart';

@immutable
abstract class UpdateOwnerState {}

class UpdateOwnerInitial extends UpdateOwnerState {}

class UpdateOwnerProgress extends UpdateOwnerState {}

class UpdateOwnerSucceed extends UpdateOwnerState {}

class UpdateOwnerFailed extends UpdateOwnerState {
  final String message;
  UpdateOwnerFailed({required this.message});
}
