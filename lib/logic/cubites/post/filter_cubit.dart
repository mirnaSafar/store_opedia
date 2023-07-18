import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/repositories/filter_repository.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  List<dynamic> filteredPosts = [];
  FilterCubit() : super(FilterInitial());

  Future filterPostsWithCategory(
      {required String category, bool onlyShowSubcategories = false}) async {
    //check the internetCubit
    // postsFilterdWithCategory.clear();

    Map<String, dynamic>? response;
    emit(FilterProgress());
    try {
      response = await FilterRepository()
          .getPostsFilteredWithCategory(category: category);
    } catch (e) {
      emit(FilterFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
    // if (response == null) emit(FilterFailed(message: 'Failed'));
    if (response != null && response["message"] == "Success") {
      filteredPosts = response["posts"] as List;
      List<String> subCategries = response["subCategories"] as List<String>;
      if (filteredPosts.isEmpty) {
        emit(NoPostYet());
      }
      if (subCategries.isEmpty && onlyShowSubcategories) {
        emit(NoSubCategories());
      } else {
        emit(FilterState(filteredPosts: filteredPosts));

        emit(FilteredSuccessfully());
        if (subCategries.isNotEmpty && onlyShowSubcategories) {
          emit(CategoriesFilteredSuccessfully(subCategories: subCategries));
        }
      }
    } else {
      emit(FilterFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
  }

  Future filterPostsWithRatings() async {
    //check the internetCubit
    emit(FilterProgress());
    Map<String, dynamic>? response =
        await FilterRepository().getPostsFilteredWithRatings();
    try {
      response = await FilterRepository().getPostsFilteredWithRatings();
    } catch (e) {
      emit(FilterFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
    if (response != null && response["message"] == "Success") {
      filteredPosts = response["posts"] as List<dynamic>;
      if (filteredPosts.isEmpty) {
        emit(NoPostYet());
      } else {
        emit(FilterState(filteredPosts: filteredPosts));
        emit(FilteredSuccessfully());
      }
    } else {
      emit(FilterFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
  }

  Future filterPostsWithLocation({required String location}) async {
    //check the internetCubit
    // filteredPosts.clear();
    Map<String, dynamic>? response;
    emit(FilterProgress());
    try {
      response = await FilterRepository()
          .getPostsFilteredWithLocation(location: location);
    } catch (e) {
      emit(FilterFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
    // if (response == null) emit(FilterFailed(message: 'Failed'));
    if (response != null && response["message"] == "Success") {
      filteredPosts = response["posts"] as List;
      if (filteredPosts.isEmpty) {
        emit(NoPostYet());
      } else {
        emit(FilterState(filteredPosts: filteredPosts));
        emit(FilteredSuccessfully());
      }
    } else {
      emit(FilterFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
  }

  Future getOldestPosts() async {
    emit(FilterProgress());
    if (filteredPosts.isEmpty) {
      emit(NoPostYet());
    } else {
      filteredPosts = List.from(filteredPosts.reversed);
      emit(FilterState(filteredPosts: filteredPosts));
      emit(FilteredSuccessfully());
    }
  }

  Future getAllPosts() async {
    //check the internetCubit
    // filteredPosts.clear();
    Map<String, dynamic>? response;
    emit(FilterProgress());
    try {
      response = await PostsRepository().getAllPosts();
    } catch (e) {
      emit(FilterFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
    // if (response == null) emit(FilterFailed(message: 'Failed'));

    if (response == null) {
      emit(FilterFailed(
          message: "Failed to Get the Posts , Check your internet connection"));
    } else if (response["message"] == "You dont have any followed store yet") {
      emit(NoPostYet());
    } else if (response["message"] == "Done") {
      filteredPosts = response["posts"];
      emit(FilteredSuccessfully());
    } else {
      emit(FilterFailed(message: response["message"]));
    }
  }
}
