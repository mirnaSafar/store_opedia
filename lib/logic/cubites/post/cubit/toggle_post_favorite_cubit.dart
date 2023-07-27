import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';

part 'toggle_post_favorite_state.dart';

class TogglePostFavoriteCubit extends Cubit<TogglePostFavoriteState> {
  TogglePostFavoriteCubit() : super(ToggoleFavoritePostInitial());

  Future toggolePostFavorite(
      {required String postID, required String ownerID}) async {
    emit(ProgressToggoleFavoritePost());
    Map<String, dynamic>? response = await PostsRepository()
        .toggoleFavoritePost(postID: postID, ownerID: ownerID);
    if (response == null || response["message"] == "Access Denied") {
      emit(FailedToggoleFavoritePost(response == null
          ? "Failed to add this post to favorites , Check your Internet Connection"
          : response["message"]));
    } else {
      emit(SucceedToggoleFavoritePost(message: response["message"]));
    }
  }
}
