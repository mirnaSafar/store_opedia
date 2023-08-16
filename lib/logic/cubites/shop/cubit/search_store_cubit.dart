import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';

part 'search_store_state.dart';

class SearchStoreCubit extends Cubit<SearchStoreState> {
  List<dynamic> searchResult = [];
  SearchStoreCubit() : super(SearchStoreInitial(searchResult: []));
  Future searchStore({required String ownerID, required String search}) async {
    emit(SearchStoreProgress());
    Map<String, dynamic>? response;
    try {
      response =
          await ShopRepository().searchStore(ownerID: ownerID, search: search);
    } catch (e) {
      emit(SearchStoreFailed(
          message: response == null
              ? "Faild Search , Check your internet connection"
              : response["message"]));
    }
    if (response != null && response['message'] == 'Done') {
      searchResult = response['stores'] as List<dynamic>;
      SearchStoreState(searchResult: searchResult);
      emit(SearchStoreSuccessed(searchResult: searchResult));
    } else if (response != null && response['message'] == '') {
      emit(NoSearchResult());
    }
  }
}
