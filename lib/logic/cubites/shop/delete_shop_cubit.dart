import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/logic/cubites/shop/get_owner_shops_cubit.dart';
import 'package:shopesapp/main.dart';

import '../../../../data/repositories/shop_repository.dart';

part 'delete_shop_state.dart';

class DeleteShopCubit extends Cubit<DeleteShopState> {
  DeleteShopCubit() : super(DeleteShopInitial());

  Future deleteShop({required String shopID}) async {
    emit(DeleteShopProgress());
    String? ownerID = globalSharedPreference.getString("ID");

    String response =
        await ShopRepository().deleteShop(shopID: shopID, ownerID: ownerID!);

    if (response == "Failed") {
      emit(DeleteShopFailed(
          message:
              "Failed to delete the Shop , Check your internet connection"));
    } else {
      emit(DeleteShopSucceed());
    }
  }
}
