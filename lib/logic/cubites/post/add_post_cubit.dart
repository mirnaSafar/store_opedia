import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/main.dart';

import '../../../data/repositories/posts_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  Future addPost(
      {required String postImageType,
      required String shopeID,
      required String title,
      required String description,
      required String? postImage,
      required String category,
      required String price}) async {
    emit(AddPostProgress());
    String response = await PostsRepository().addPost(
        shopeID: shopeID,
        postImageType: postImageType,
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
