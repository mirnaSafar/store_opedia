import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositories/shop_repository.dart';

part 'toggole_favorite_shop_state.dart';

class ToggoleFavoriteShopCubit extends Cubit<ToggoleFavoriteShopState> {
  ToggoleFavoriteShopCubit() : super(ToggoleFavoriteShopInitial());

  Future toggoleFavoriteShop(
      {required String shopID, required String ownerID}) async {
    emit(ProgressToggoleFavoriteShop());
    Map<String, dynamic>? response = await ShopRepository()
        .toggoleFollowShop(shopID: shopID, userID: ownerID);
    if (response == null || response["message"] == "Access Denied") {
      ScaffoldMessenger(
          child: Text(response == null
              ? "Failed to favorite this Shop , Check your Internet Connection"
              : response["message"]));
      emit(FailedToggoleFavoriteShop(response == null
          ? "Failed to favorite this Shop , Check your Internet Connection"
          : response["message"]));
    } else {
      const ScaffoldMessenger(child: Text('Rated Successfuly!'));
      emit(SucceedToggoleFavoriteShop(message: response["message"]));
    }
  }
}
