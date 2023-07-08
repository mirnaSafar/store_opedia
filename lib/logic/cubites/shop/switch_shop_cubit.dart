import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
import 'package:shopesapp/logic/cubites/shop/work_time_cubit.dart';
import 'package:shopesapp/main.dart';
part 'switch_shop_state.dart';

class SwitchShopCubit extends Cubit<SwitchShopState> {
  SwitchShopCubit() : super(SwitchShopInitial());

  String? idofSelectedShop;
  void setIDOfSelectedShop({required String? id}) {
    globalSharedPreference.setString("shopID", id!);
  }

  String? getStoredShopID() {
    idofSelectedShop = globalSharedPreference.getString("shopID") ?? "noID";
    setIDOfSelectedShop(id: idofSelectedShop);
    return idofSelectedShop;
  }

  Future swithShop({required var shop}) async {
    emit(SwithShopProgress());
    Shop _shop = Shop.fromMap(shop);

    if (_shop == null) {
      emit(SwithShopFiled());
    } else {
      AuthRepository().saveOwnerAndShop(shop: _shop);
      emit(SwithShopSucceded());
    }
  }

  /* @override
  SwitchShopState? fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(SwitchShopState state) {
    return state.toMap();
  }*/
}
