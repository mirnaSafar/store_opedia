import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/shop_repository.dart';
import '../../../../main.dart';

part 'active_shop_state.dart';

class ActiveShopCubit extends Cubit<ActiveShopState> {
  ActiveShopCubit() : super(ActiveShopInitial());

  Future activeShop({required String shopID}) async {
    emit(ActiveProgress());
    String? ownerID = globalSharedPreference.getString("ID");

    String response =
        await ShopRepository().deleteShop(shopID: shopID, ownerID: ownerID!);

    if (response == "Failed") {
      emit(ActiveShopFailed(
          message:
              "Failed to delete the Shop , Check your internet connection"));
    } else {
      emit(ActiveShopSucceed());
    }
  }
}
