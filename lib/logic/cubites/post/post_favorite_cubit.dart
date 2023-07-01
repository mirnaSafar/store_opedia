import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';

part 'post_favorite_state.dart';

class PostFavoriteCubit extends Cubit<PostFavoriteState> {
  late List<dynamic> updatedFavoritePosts;
  PostFavoriteCubit() : super(PostFavoriteState(favoritePosts: [])) {
    state.favoritePosts = SharedPreferencesRepository.getFavoritePosts();
    updatedFavoritePosts = state.favoritePosts;
  }

  void addToFavorites(Post post) {
    if (!post.isFavorit!) {
      post.isFavorit = true;
      updatedFavoritePosts = state.favoritePosts..add(post.toJson());
    }
    SharedPreferencesRepository.setFavoritePosts(
        favoritePostsList: updatedFavoritePosts);
    emit(PostFavoriteState(favoritePosts: updatedFavoritePosts));
  }

  void removeFromFavorites(Post post) {
    post.isFavorit = false;
    updatedFavoritePosts = state.favoritePosts
      ..removeWhere((jsonPost) =>
          Post.fromJson(jsonPost).postID == post.postID &&
          Post.fromJson(jsonPost).shopeID == post.shopeID &&
          Post.fromJson(jsonPost).ownerID == post.ownerID);
    SharedPreferencesRepository.setFavoritePosts(
        favoritePostsList: updatedFavoritePosts);
    emit(PostFavoriteState(favoritePosts: updatedFavoritePosts));
  }

  bool isPostFavorite(Post post) => state.favoritePosts.contains(post.toJson());
}
