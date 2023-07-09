import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/internet_cubit.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

import '../../../data/repositories/posts_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  List<dynamic> newestPosts = [];
  List<dynamic> oldestPosts = [];

  List<dynamic> ownerPosts = [];

  void setOwnerPost({required var posts}) {
    ownerPosts = posts;
  }

  PostsCubit() : super(PostsInitial());

/*  Future getPosts() async {
//Test the internet Cubit check tht connection
    emit(FeatchingPostsProgress());
    BlocListener<InternetCubit, InternetState>(
      listener: (context, state) async {
        if (state is InternetConnected) {
          Map<String, dynamic>? response = await PostsRepository().getPosts();
          if (response!["message"] == "Success") {
            newestPosts = response["posts"] as List;
            if (newestPosts.isEmpty) {
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
  }*/

  Future getOwnerPosts({
    required String ownerID,
    required String shopID,
  }) async {
    emit(FeatchingPostsProgress());
    Map<String, dynamic>? response = await PostsRepository().getShopPosts(
      ownerID: ownerID,
      shopID: shopID,
    );
    if (response!["message"] == "Success") {
      newestPosts = response["posts"] as List;
      if (newestPosts.isEmpty) {
        emit(NoPostYet());
      } else {
        setOwnerPost(posts: response["posts"]);
        emit(PostsFetchedSuccessfully());
      }
    } else {
      emit(ErrorFetchingPosts(message: response["message"]));
    }
  }

  Future getOldestPosts() async {
    emit(FeatchingPostsProgress());
    if (newestPosts.isEmpty) {
      emit(NoPostYet());
    } else {
      oldestPosts = List.from(newestPosts.reversed);
      emit(OldestPostsFiltered());
    }
  }
}
