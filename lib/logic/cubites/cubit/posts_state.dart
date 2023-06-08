part of 'posts_cubit.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsFetchedSuccessfully extends PostsState {}

class ErrorFetchingPosts extends PostsState {
  String message;
  ErrorFetchingPosts({required this.message});
}

class NoPostYet extends PostsState {}

class FeatchingPostsProgress extends PostsState {}

class OldestPostsFiltered extends PostsState {}

class DeletePostProgress extends PostsState {}

class DeletePostSucceed extends PostsState {}

class DeletePostFailed extends PostsState {
  final String message;
  DeletePostFailed({required this.message});
}

class UpdatePostProgress extends PostsState {}

class UpdatePostSucceed extends PostsState {}

class UpdatePostFailed extends PostsState {
  final String message;
  UpdatePostFailed({required this.message});
}

class AddPostProgress extends PostsState {}

class AddPostSucceed extends PostsState {}

class AddPostFailed extends PostsState {
  final String message;
  AddPostFailed({required this.message});
}
