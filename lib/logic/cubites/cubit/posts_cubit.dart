import 'package:bloc/bloc.dart';

import '../../../data/repositories/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository _postsRepository;
  late List _newestPosts = [];
  late List _oldestPosts = [];

  PostsCubit(this._postsRepository) : super(PostsInitial());

  Future getPosts() async {
//Test the internet Cubit check tht connection

    emit(FeatchingPostsProgress());
    Map<String, dynamic>? response = await _postsRepository.getPosts();
    if (response!["message"] == "Success") {
      _newestPosts = response["posts"] as List;
      if (_newestPosts.isEmpty) {
        emit(NoPostYet());
      } else {
        emit(PostsFetchedSuccessfully());
      }
    } else {
      emit(ErrorFetchingPosts(message: response["message"]));
    }
  }

  Future getOldestPosts() async {
    emit(FeatchingPostsProgress());
    if (_newestPosts.isEmpty) {
      emit(NoPostYet());
    } else {
      _oldestPosts = List.from(_newestPosts.reversed);
      emit(OldestPostsFiltered());
    }
  }

  Future deletePost({required String postID}) async {
    emit(DeletePostProgress());
    String response = await _postsRepository.deletePost(postID: postID);
    if (response == "Failed") {
      emit(DeletePostFailed(
          message:
              "Failed to delete the Post , Check your internet connection"));
    } else {
      emit(DeletePostSucceed());
    }
  }

  Future updatePost(
      {required String postID,
      required String shopID,
      required String title,
      required String description,
      required List<String>? postImages,
      required String category,
      required String productPrice}) async {
    String response = await _postsRepository.updatePost(
        postID: postID,
        shopID: shopID,
        title: title,
        description: description,
        postImages: postImages,
        category: category,
        productPrice: productPrice);
    if (response == "Failed") {
      emit(UpdatePostFailed(
          message:
              "Failed to Update the Post , Check your internet connection"));
    } else {
      emit(UpdatePostSucceed());
    }
  }

  Future addPost(
      {required String shopID,
      required String title,
      required String description,
      required List<String>? postImages,
      required String category,
      required String productPrice}) async {
    emit(AddPostProgress());
    String response = await _postsRepository.addPost(
        shopID: shopID,
        title: title,
        description: description,
        postImages: postImages,
        category: category,
        productPrice: productPrice);
    if (response == "Failed") {
      emit(AddPostFailed(
          message: "Failed to Add the Post , Check your internet connection"));
    } else {
      emit(AddPostSucceed());
    }
  }
}
