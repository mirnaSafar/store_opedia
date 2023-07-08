import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';
import 'package:shopesapp/main.dart';
part 'get_owner_shops_state.dart';

class GetOwnerShopsCubit extends Cubit<GetOwnerShopsState> {
  GetOwnerShopsCubit() : super(GetOwnerShopsInitial());

  List<dynamic> ownerShops = [];

  void setOwnerShop({required List<dynamic> shops}) {
    ownerShops = shops;
  }

  Future getOwnerShopsRequest() async {
    emit(GetOwnerShopsProgress());

    Map<String, dynamic>? response = /*_shopRepository.getOwnerShposTest();*/
        await ShopRepository()
            .getOwnerShpos(ownerID: globalSharedPreference.getString("ID"));
    if (response!["message"] == "Succeed") {
      setOwnerShop(shops: response["shops"]);

      emit(GetOwnerShopsSucceed());
    } else if (response["message"] != "Succeed") {
      emit(GetOwnerShopsFiled(
          message: response == null
              ? "Filed to delet the user , Check your internet connection"
              : response["message"]));
    }
  }
}
