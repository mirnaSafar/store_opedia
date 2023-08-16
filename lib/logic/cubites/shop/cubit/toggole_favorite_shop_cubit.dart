import 'package:bloc/bloc.dart';

import '../../../../data/repositories/shop_repository.dart';

part 'toggole_favorite_shop_state.dart';

class ToggoleFavoriteShopCubit extends Cubit<ToggoleFavoriteShopState> {
  ToggoleFavoriteShopCubit() : super(ToggoleFavoriteShopInitial());

  Future toggoleFavoriteShop(
      {required String shopID, required String ownerID}) async {
    emit(ProgressToggoleFavoriteShop());
    Map<String, dynamic>? response = await ShopRepository()
        .toggoleFavoriteShop(shopID: shopID, ownerID: ownerID);
    if (response == null || response["message"] == "Access Denied") {
      emit(FailedToggoleFavoriteShop(response == null
          ? "Failed to favorite this Shop , Check your Internet Connection"
          : response["message"]));
    } else {
      emit(SucceedToggoleFavoriteShop(message: response["message"]));
    }
  }
}
