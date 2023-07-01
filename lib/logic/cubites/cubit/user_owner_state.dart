part of 'user_owner_cubit.dart';

class UserOwnerState {
  Owner? owner;
  UserOwnerState(this.owner);
}

// ignore: must_be_immutable
class UserOwnerInitial extends UserOwnerState {
  UserOwnerInitial(Owner? owner) : super(owner);
}
