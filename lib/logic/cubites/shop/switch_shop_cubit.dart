import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
import 'package:shopesapp/main.dart';
part 'switch_shop_state.dart';

class SwitchShopCubit extends Cubit<SwitchShopState> {
  SwitchShopCubit() : super(SwitchShopInitial());

  /*String? idofSelectedShop;
  void setIDOfSelectedShop({required String? id}) {
    globalSharedPreference.setString("CurrentShopID", id!);
  }

  String? getStoredShopID() {
    idofSelectedShop = globalSharedPreference.getString("CurrentShopID");
    setIDOfSelectedShop(id: idofSelectedShop);
    return idofSelectedShop;
  }*/

  Future swithShop({required var shop}) async {
    emit(SwithShopProgress());
    Shop _shop = Shop.fromMap(shop);

    // ignore: unnecessary_null_comparison
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
