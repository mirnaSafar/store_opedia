import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopesapp/translation/locale_keys.g.dart';

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
      emit(ContactUsFailed(message: LocaleKeys.failed_to_contact_with_Us.tr()));
    } else {
      emit(ContactUsSucceed());
    }
  }
}
