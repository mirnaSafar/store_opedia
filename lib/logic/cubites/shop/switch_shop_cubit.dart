import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/auth_repository.dart';
part 'switch_shop_state.dart';

class SwitchShopCubit extends Cubit<SwitchShopState> {
  SwitchShopCubit(this._authRepository) : super(SwitchShopInitial());
  String? idofSelectedShop;
  final AuthRepository _authRepository;
  void setIDOfSelectedShop({required String? id}) {
    idofSelectedShop = id;
  }

  void getStoredShopID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idofSelectedShop = prefs.getString("shopID") ?? "noID";
    setIDOfSelectedShop(id: idofSelectedShop);
    print("sotred one " + idofSelectedShop!);
  }

  Future swithShop({required var shop}) async {
    emit(SwithShopProgress());
    Shop _shop = Shop.fromMap(shop);

    if (_shop == null) {
      emit(SwithShopFiled());
    } else {
      _authRepository.saveOwnerAndShop(shop: _shop);

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
