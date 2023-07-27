import 'package:bloc/bloc.dart';

import '../../../../data/repositories/shop_repository.dart';

part 'show_favorite_stores_state.dart';

class ShowFavoriteStoresCubit extends Cubit<ShowFavoriteStoresState> {
  List<dynamic> favoriteStores = [];
  ShowFavoriteStoresCubit() : super(ShowFavoriteStoresInitial());
  Future showMyFavoriteStores({required String ownerID}) async {
    emit(ShowFavoriteStoresProgress());
    Map<String, dynamic>? response;
    try {
      response = await ShopRepository().showFavoriteStores(ownerID: ownerID);
    } catch (e) {
      emit(ShowFavoriteStoresFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
    if (response != null && response['message'] == 'Done') {
      favoriteStores = response['favs'] as List<dynamic>;
      // emit(ShowFavoriteStoresState(favoriteStores: favoriteStores));
      emit(ShowFavoriteStoresSuccessed());
    } else if (response != null &&
        response['message'] == 'You dont have any favourite stores yet') {
      emit(NoFavoriteStores());
    }
  }
}
