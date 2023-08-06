import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';

import '../../../data/enums/message_type.dart';
import '../../../presentation/shared/custom_widgets/custom_toast.dart';

part 'rate_shop_state.dart';

class RateShopCubit extends Cubit<RateShopState> {
  RateShopCubit() : super(RateShopInitial(rate: 0));

  double? ratevalue = 0.0;

  Future<void> setShopRating({
    required double newRate,
    required userID,
    required shopId,
    required context,
    required size,
  }) async {
    Map<String, dynamic>? response = await ShopRepository()
        .sendShopRating(userID: userID, shopID: shopId, rateValue: newRate);
    if (response == null ||
        response["message"] == "You cannot rate your store") {
      CustomToast.showMessage(
          context: context,
          size: size,
          message: "Some thing Wrong",
          messageType: MessageType.REJECTED);

      emit(RateShopFailed(rate: ratevalue!));
    } else if (response["message"] == "Done") {
      ratevalue = response["ratingNumber"];
      CustomToast.showMessage(
          context: context,
          size: size,
          message: "Success",
          messageType: MessageType.SUCCESS);
      SharedPreferencesRepository.setStoreRate(
          ownerId: userID, shopId: shopId, rate: newRate);
      emit(RateShopSucceded(rate: ratevalue!));
    }
  }

  Future sendRating({
    required String ownerID,
    required String shopID,
    required double rateValue,
  }) async {
    Map<String, dynamic>? response = await ShopRepository()
        .sendShopRating(userID: ownerID, shopID: shopID, rateValue: rateValue);
    if (response == null ||
        response["message"] == "You cannot rate your store") {
      const ScaffoldMessenger(child: Text('Something went wrong!'));
    } else if (response["message"] == "Done") {
      ratevalue = response["ratingNumber"];
      SharedPreferencesRepository.setStoreRate(
          ownerId: ownerID, shopId: shopID, rate: rateValue);
      emit(RateShopState(rate: rateValue));
    }
  }

  double getShopRating({required ownerId, required shopId}) {
    return SharedPreferencesRepository.getStoreRate(
        ownerId: ownerId, shopId: shopId);
  }
}
