import 'package:bloc/bloc.dart';

import '../../../../data/repositories/user_repository.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  Future contactUS({
    required String id,
    required String type,
    required String description,
    //   required String? photo,
  }) async {
    emit(ContactUsProgress());

    String? response = await UserRepository()
        .contactUS(id: id, type: type, description: description, photo: "");

    if (response == "Failed") {
      emit(ContactUsFailed(
          message: "Failed to ContactUs , Check your internet connection"));
    } else {
      emit(ContactUsSucceed());
    }
  }
}
