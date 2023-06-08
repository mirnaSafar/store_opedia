part of 'owner_cubit.dart';

@immutable
abstract class OwnerState {}

class OwnerInitial extends OwnerState {}

class OwnerProgress extends OwnerState {}

class OwnerLoggedin extends OwnerState {
  final Owner owner;
  OwnerLoggedin({required this.owner});
}

class OwnerLoggedinSuccessfully extends OwnerState {}

class OwnerLoggedinFailed extends OwnerState {}

class OwnerSignedUp extends OwnerState {}

class OwnerFailed extends OwnerState {
  final String message;
  OwnerFailed(this.message);
}

class OwnerNoToken extends OwnerState {}
