import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/models/owner.dart';
import 'package:shopesapp/data/repositories/owner_repository.dart';

part 'owner_state.dart';


// USER AND OWNER USE THE SAME CUBIT (USER CUBIT)
// WE CAN DELETE THIS FILE
/*
class OwnerCubit extends Cubit<OwnerState> {
  Owner owner;
  OwnerCubit({required this.owner}) : super(OwnerInitial({} as Owner));

  /*Future updateOwner(
      {required String id,
      required String userName,
      required String email,
      required String password,
      required Shop currentShop,
      required String phoneNumber}) async {
    emit(UpdateOwnerProgress());

    Map<String, dynamic>? response = await OwnerRepository().updateOwner(
        id: id,
        userName: userName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        currentShop: currentShop);
    if (response == null ||
        response['message'] != 'Owner has been Updated successfully') {
      emit(UpdateOwnerFailed(
          message: response == null
              ? "Failed to Update the user , Check your internet connection"
              : response['message']));
    } else {
      SharedPreferencesRepository.saveUpdatedUser(
          userName: userName, phoneNumber: phoneNumber, password: password);

      emit(UpdateOwnerSucceed());
    }
  }*/

  Future deleteOwner({required String id}) async {
    emit(DeleteOwnerProgress());
    String response = await OwnerRepository().deleteOwner(id: id);
    if (response == "Field") {
      emit(DeleteOwnerFailed(
          message:
              "Failed to delet the user , Check your internet connection"));
    } else if (response == "Success") {
      emit(DeleteOwnerSucceed());
    }
  }
}
*/