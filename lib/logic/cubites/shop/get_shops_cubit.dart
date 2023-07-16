import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/main.dart';

import '../../../data/repositories/shop_repository.dart';

part 'get_shops_state.dart';

class GetShopsCubit extends Cubit<GetShopsState> {
  GetShopsCubit() : super(GetShopsInitial());
  List<dynamic> _shops = [];
  Shop? shop;

  void setShops({required var shops}) {
    _shops = shops;
  }

  Future getShops() async {
    emit(GetShopsProgress());

    Map<String, dynamic>? response = await ShopRepository()
        .getShops(ownerID: globalSharedPreference.getString("ID")!);
    if (response!["message"] == "Done") {
      setShops(shops: response["stores"]);

      emit(GetShopsSucceed());
    } else if (response["message"] != "Done") {
      emit(GetShopsFailed(
          message: response == null
              ? "Filed to delet the user , Check your internet connection"
              : response["message"]));
    }
  }

  Future<dynamic> getShop(String shopID) async {
    emit(GetShopsProgress());

    Map<String, dynamic>? response = await ShopRepository()
        .getShops(ownerID: globalSharedPreference.getString("ID")!);
    if (response!["message"] == "Done") {
      setShops(shops: response["stores"]);
      shop = _shops
          .firstWhere((element) => Shop.fromJson(element).shopID == shopID);
      emit(GetShopsSucceed());
      return shop!;
    } else if (response["message"] != "Done") {
      emit(GetShopsFailed(
          message: response == null
              ? "Filed to delet the user , Check your internet connection"
              : response["message"]));
    }
  }
}
