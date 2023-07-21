import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/shop_repository.dart';

part 'active_shop_state.dart';

class ActiveShopCubit extends Cubit<ActiveShopState> {
  ActiveShopCubit() : super(ActiveShopInitial());

  Future activeShop({required String shopID, required String ownerID}) async {
    emit(ActiveProgress());

    String? response = await ShopRepository()
        .toggleActivation(shopID: shopID, ownerID: ownerID);

    if (response == "Failed") {
      emit(ActiveShopFailed(
          message:
              "Failed to delete the Shop , Check your internet connection"));
    } else {
      emit(ActiveShopSucceed());
    }
  }
}
