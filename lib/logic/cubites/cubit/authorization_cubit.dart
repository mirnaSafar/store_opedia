import 'package:bloc/bloc.dart';

part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit() : super(AuthorizationState(isOwner: false));
  void switchToUserMode() => emit(AuthorizationState(isOwner: false));
  void switchToOwnerMode() => emit(AuthorizationState(isOwner: true));
}
