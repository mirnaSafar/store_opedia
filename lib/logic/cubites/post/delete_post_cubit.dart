import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());
  Future deletePost({required String postID}) async {
    emit(DeletePostProgress());
    String response = await PostsRepository().deletePost(postID: postID);
    if (response == "Failed") {
      emit(DeletePostFailed(
          message:
              "Failed to delete the Post , Check your internet connection"));
    } else {
      emit(DeletePostSucceed());
    }
  }
}
