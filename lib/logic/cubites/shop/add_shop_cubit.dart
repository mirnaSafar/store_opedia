import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:shopesapp/main.dart';

import '../../../../data/repositories/shop_repository.dart';
import '../../../data/models/shop.dart';
import '../../../data/repositories/auth_repository.dart';
import 'get_owner_shops_cubit.dart';

part 'add_shop_state.dart';

class AddShopCubit extends Cubit<AddShopState> {
  AddShopCubit() : super(AddShopInitial());

  Future addShop({
    required String shopName,
    required String shopDescription,
    required String? shopProfileImage,
    required String? shopCoverImage,
    required String shopCategory,
    required String location,
    required String closing,
    required String opening,
    required String shopPhoneNumber,
  }) async {
    emit(AddShopProgress());
    String response = await ShopRepository().addShop(
      ownerID: globalSharedPreference.getString("ID")!,
      shopName: shopName,
      shopDescription: shopDescription,
      shopProfileImage: shopProfileImage,
      shopCoverImage: shopCoverImage,
      shopCategory: shopCategory,
      location: location,
      closing: closing,
      opening: opening,
      shopPhoneNumber: shopPhoneNumber,
    );

    if (response == "Failed") {
      emit(AddShopFailed(
          message: "Failed to Add the Shop , Check your internet connection"));
    } else {
      if (globalSharedPreference.getString("mode") == "user") {
        GetOwnerShopsCubit().getOwnerShopsRequest();
        emit(AddShopSucceed());
      }
    }
  }
}
