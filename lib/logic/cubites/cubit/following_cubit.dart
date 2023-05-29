import 'package:bloc/bloc.dart';

part 'following_state.dart';

class FollowingCubit extends Cubit<FollowingState> {
  FollowingCubit() : super(FollowingState(followed: false));

  void follow() => emit(FollowingState(followed: true));
  void unfollow() => emit(FollowingState(followed: false));
}
