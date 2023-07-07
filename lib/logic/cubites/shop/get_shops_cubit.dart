import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/main.dart';

import '../../../data/repositories/shop_repository.dart';

part 'get_shops_state.dart';

class GetShopsCubit extends Cubit<GetShopsState> {
  GetShopsCubit() : super(GetShopsInitial());
  List<dynamic> _shops = [];

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
    } else if (response == null || response["message"] != "Done") {
      emit(GetShopsFailed(
          message: response == null
              ? "Filed to delet the user , Check your internet connection"
              : response["message"]));
    }
  }
}
