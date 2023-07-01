import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/posts_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this._postsRepository) : super(AddPostInitial());
  final PostsRepository _postsRepository;
  Future addPost(
      {
      //required String ownerName,
      required String shopeID,
      required String ownerPhoneNumber,
      required String shopeName,
      //required List<String> socialUrls,
      required String location,
      required String title,
      required String description,
      required String? postImage,
      required String category,
      required String productPrice}) async {
    emit(AddPostProgress());
    String response = await _postsRepository.addPost(
        location: location,
        //socialUrls:socialUrls,
        ownerPhoneNumber: ownerPhoneNumber,
        shopeID: shopeID,
        shopeName: shopeName,
        title: title,
        description: description,
        postImage: postImage,
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
