import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';

import '../../../../data/repositories/shop_repository.dart';
import '../../../../main.dart';
import 'get_owner_shops_cubit.dart';

part 'edit_shop_state.dart';

class EditShopCubit extends Cubit<EditShopState> {
  EditShopCubit() : super(EditShopInitial());

  Future editShop({
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
    emit(EditShopProgress());
    String response = await ShopRepository().editShop(
      ownerID: globalSharedPreference.getString("ID")!,
      shopID: globalSharedPreference.getString("shopID")!,
      shopName: shopName,
      shopDescription: shopDescription,
      shopProfileImage: shopProfileImage,
      shopCoverImage: shopCoverImage,
      shopCategory: shopCategory,
      location: location,
      startWorkTime: opening,
      endWorkTime: closing,
      shopPhoneNumber: shopPhoneNumber,
    );

    if (response == "Failed") {
      emit(EditShopFailed(
          message: "Failed to Add the Shop , Check your internet connection"));
    } else {
      AuthRepository().saveOwnerAndShop(
          shop: Shop(
              shopCoverImage: shopCoverImage,
              shopDescription: shopDescription,
              shopPhoneNumber: shopPhoneNumber,
              shopProfileImage: shopProfileImage,
              socialUrl: "",
              shopCategory: shopCategory,
              location: location,
              startWorkTime: opening,
              endWorkTime: closing,
              ownerID: globalSharedPreference.getString("ID")!,
              ownerEmail: globalSharedPreference.getString("email")!,
              ownerPhoneNumber:
                  globalSharedPreference.getString("phoneNumber")!,
              shopID: globalSharedPreference.getString("shopID")!,
              shopName: shopName,
              ownerName: globalSharedPreference.getString("name")!));
      GetOwnerShopsCubit().getOwnerShopsRequest();

      emit(EditShopSucceed());
    }
  }
}
