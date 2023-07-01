import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';

part 'rate_shop_state.dart';

class RateShopCubit extends Cubit<RateShopState> {
  // String ownerId, shopId;
  RateShopCubit() : super(RateShopInitial(rate: 0
            //  SharedPreferencesRepository.getStoreRate(
            //     ownerId: ownerId, shopId: shopId)
            ));

  Future<void> setShopRating(
      {required double newRate, required ownerId, required shopId}) async {
    if (newRate > 3.0) {
      String? response =
          await ShopRepository().sendShopRating(ownerId, shopId, newRate);
      if (response == 'Success') {
        SharedPreferencesRepository.setStoreRate(
            ownerId: ownerId, shopId: shopId, rate: newRate);
        emit(RateShopState(rate: newRate));
      } else {
        const ScaffoldMessenger(child: Text('Something went wrong!'));
      }
    }
  }

  double getShopRating({required ownerId, required shopId}) {
    return SharedPreferencesRepository.getStoreRate(
        ownerId: ownerId, shopId: shopId);
    // state.rate;
  }
}
