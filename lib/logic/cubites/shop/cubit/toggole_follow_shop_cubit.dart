import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';

part 'toggole_follow_shop_state.dart';

class ToggoleFollowShopCubit extends Cubit<ToggoleFollowShopState> {
  ToggoleFollowShopCubit() : super(ToggoleFollowShopInitial());

  Future toggoleFolowShop(
      {required String shopID, required String ownerID}) async {
    emit(ProgressToggoleFollowShop());
    Map<String, dynamic>? response = await ShopRepository()
        .toggoleFollowShop(shopID: shopID, ownerID: ownerID);
    if (response == null || response["message"] == "Access Denied") {
      emit(FailedToggoleFollowShop(response == null
          ? "Failed to Follow this Shop , Check your Internet Connection"
          : response["message"]));
    } else {
      emit(SucceedToggoleFollowShop(message: response["message"]));
    }
  }
}
