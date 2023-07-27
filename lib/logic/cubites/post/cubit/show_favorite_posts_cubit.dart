import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';

part 'show_favorite_posts_state.dart';

class ShowFavoritePostsCubit extends Cubit<ShowFavoritePostsState> {
  List<dynamic> favoritePosts = [];
  ShowFavoritePostsCubit() : super(ShowFavoritePostsInitial());
  Future showMyFavoritePosts({required String ownerID}) async {
    emit(ShowFavoritePostsProgress());
    Map<String, dynamic>? response;
    try {
      response = await PostsRepository().showFavoritePosts(ownerID: ownerID);
    } catch (e) {
      emit(ShowFavoritePostsFailed(
          message: response == null
              ? "Faild Filter , Check your internet connection"
              : response["message"]));
    }
    if (response != null && response['message'] == 'Done') {
      favoritePosts = response['PostsLikedByMe'] as List<dynamic>;
      // emit(ShowFavoritePostsState(favoritePosts: favoritePosts));
      emit(ShowFavoritePostsSuccessed());
    } else if (response != null &&
        response['message'] == 'You didnt like any post yet') {
      emit(NoFavoritePosts());
    }
  }
}
