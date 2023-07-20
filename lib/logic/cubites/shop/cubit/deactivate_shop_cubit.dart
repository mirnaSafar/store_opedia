import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/shop_repository.dart';
import '../../../../main.dart';

part 'deactivate_shop_state.dart';

class DeactivateShopCubit extends Cubit<DeactivateShopState> {
  DeactivateShopCubit() : super(DeactivateShopInitial());

  Future deactivateShop({required String shopID}) async {
    emit(DeactivateShopProgress());
    String? ownerID = globalSharedPreference.getString("ID");

    String response =
        await ShopRepository().deleteShop(shopID: shopID, ownerID: ownerID!);

    if (response == "Failed") {
      emit(DeactivateShopFailed(
          message:
              "Failed to delete the Shop , Check your internet connection"));
    } else {
      emit(DeactivateShopSucceed());
    }
  }
}
