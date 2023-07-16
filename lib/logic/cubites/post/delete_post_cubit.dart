import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());
  Future deletePost(
      {required String postID,
      required String shopID,
      required String ownerID}) async {
    emit(DeletePostProgress());
    String response = await PostsRepository()
        .deletePost(postID: postID, shopID: shopID, ownerID: ownerID);
    if (response == "Failed") {
      emit(DeletePostFailed(
          message:
              "Failed to delete the Post , Check your internet connection"));
    } else {
      emit(DeletePostSucceed());
    }
  }
}
