import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/repositories/filter_repository.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterRepository filterRepository;
  late List _postsFilterdWithLocation = [];
  late List _postsFilterdWithRatings = [];
  late List _postsFilterdWithCategory = [];
  FilterCubit(this.filterRepository) : super(FilterInitial());

  Future filterPostsWithCategory({required String category}) async {
    //check the internetCubit
    _postsFilterdWithCategory.clear();
    emit(FilterProgress());
    Map<String, dynamic>? response =
        await filterRepository.getPostsFilteredWithCategory(category: category);
    if (response!["message"] == "Success") {
      _postsFilterdWithCategory = response["posts"] as List;
      if (_postsFilterdWithCategory.isEmpty) {
        emit(NoPostYet());
      } else {
        emit(CategoriesFilteredSuccessfully());
      }
    } else {
      emit(FilterFailed(message: response["message"]));
    }
  }

  Future filterPostsWithRatings() async {
    //check the internetCubit
    emit(FilterProgress());
    Map<String, dynamic>? response =
        await filterRepository.getPostsFilteredWithRatings();
    if (response!["message"] == "Success") {
      _postsFilterdWithRatings = response["posts"] as List;
      if (_postsFilterdWithRatings.isEmpty) {
        emit(NoPostYet());
      } else {
        emit(RatingsFilteredSuccessfully());
      }
    } else {
      emit(FilterFailed(message: response["message"]));
    }
  }

  Future filterPostsWithLocation({required String location}) async {
    //check the internetCubit
    _postsFilterdWithLocation.clear();
    emit(FilterProgress());
    Map<String, dynamic>? response =
        await filterRepository.getPostsFilteredWithLocation(location: location);
    if (response!["message"] == "Success") {
      _postsFilterdWithLocation = response["posts"] as List;
      if (_postsFilterdWithLocation.isEmpty) {
        emit(NoPostYet());
      } else {
        emit(LocationsFilteredSuccessfully());
      }
    } else {
      emit(FilterFailed(
          // ignore: unnecessary_null_comparison
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
  }
}
