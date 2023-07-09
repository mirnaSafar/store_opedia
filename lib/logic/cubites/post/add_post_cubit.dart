import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/main.dart';

import '../../../data/repositories/posts_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this._postsRepository) : super(AddPostInitial());
  final PostsRepository _postsRepository;
  Future addPost(
      {
      //required String ownerName,
      required String shopeID,
      required String title,
      required String description,
      required String? postImage,
      required String category,
      required String price}) async {
    emit(AddPostProgress());
    String response = await _postsRepository.addPost(
        shopeID: shopeID,
        ownerID: globalSharedPreference.getString("ID")!,
        name: title,
        description: description,
        photos: postImage,
        category: category,
        price: price);
    if (response == "Failed") {
      emit(AddPostFailed(
          message: "Failed to Add the Post , Check your internet connection"));
    } else {
      emit(AddPostSucceed());
    }
  }
}
