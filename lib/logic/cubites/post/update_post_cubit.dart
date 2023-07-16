import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';
import 'package:shopesapp/main.dart';

part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit() : super(UpdatePostInitial());
  Future updatePost(
      {required String postID,
      required String shopID,
      required String name,
      required String description,
      required String? photos,
      required String category,
      required String price}) async {
    emit(UpdatePostProgress());
    String response = await PostsRepository().updatePost(
        postID: postID,
        shopID: shopID,
        name: name,
        description: description,
        photos: photos,
        // category: category,
        price: price,
        ownerID: globalSharedPreference.getString("ID")!);
    if (response == "Failed") {
      emit(UpdatePostFailed(
          message:
              "Failed to Update the Post , Check your internet connection"));
    } else {
      emit(UpdatePostSucceed());
    }
  }
}
