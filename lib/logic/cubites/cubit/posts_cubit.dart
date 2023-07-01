import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

import '../../../data/repositories/posts_repository.dart';
import 'internet_cubit.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository _postsRepository;
  late List _newestPosts = [];
  late List _oldestPosts = [];

  PostsCubit(this._postsRepository) : super(PostsInitial());

  Future getPosts() async {
//Test the internet Cubit check tht connection
    emit(FeatchingPostsProgress());
    BlocListener<InternetCubit, InternetState>(
      listener: (context, state) async {
        if (state is InternetConnected) {
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
        } else if (state is InternetDisconnected) {
          const Center(
              child: CustomText(
            text: 'No Internet Connected',
          ));
        } else {
          const CircularProgressIndicator();
        }
      },
    );
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
}
