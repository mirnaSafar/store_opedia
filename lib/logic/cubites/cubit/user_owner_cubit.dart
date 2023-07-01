import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/models/owner.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';

part 'user_owner_state.dart';

class UserOwnerCubit extends Cubit<UserOwnerState> {
  UserOwnerCubit() : super(UserOwnerInitial(null));
  setOwner(Owner owner) {
    SharedPreferencesRepository.saveOwner(owner);
    emit(UserOwnerState(owner));
  }

  bool isUserOwner(Owner owner) =>
      SharedPreferencesRepository.getSavedOwner(owner) != null;
}
