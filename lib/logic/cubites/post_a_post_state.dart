part of 'post_a_post_cubit.dart';

@immutable
abstract class PostAPostState {}

class PostAPostInitial extends PostAPostState {}

class PostAPostProgress extends PostAPostState {}

class PostAPostSucceed extends PostAPostState {}

class PostAPostFailed extends PostAPostState {
  final String message;
  PostAPostFailed({required this.message});
}
