import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';
part 'get_owner_shops_state.dart';

class GetOwnerShopsCubit extends Cubit<GetOwnerShopsState> {
  GetOwnerShopsCubit(this._shopRepository) : super(GetOwnerShopsInitial());
  final ShopRepository _shopRepository;
  String? ownerID = "";
  List<dynamic> ownerShops = [];

  void setOwnerShop({required List<dynamic> shops}) {
    ownerShops = shops;
  }

  Future getOwnerShopsRequest() async {
    emit(GetOwnerShopsProgress());
    SharedPreferences _pref = await SharedPreferences.getInstance();
    ownerID = _pref.getString("ID");
    print(ownerID);
    Map<String, dynamic>? response = _shopRepository.getOwnerShposTest();
    //online
    /*await _shopRepository.getOwnerShpos(ownerID: ownerID);*/
    if (response!["message"] == "Succeed") {
      setOwnerShop(shops: response["shops"]);

      emit(GetOwnerShopsSucceed());
    } else if (response == null || response["message"] != "Succeed") {
      emit(GetOwnerShopsFiled(
          message: response == null
              ? "Filed to delet the user , Check your internet connection"
              : response["message"]));
    }
  }
}
