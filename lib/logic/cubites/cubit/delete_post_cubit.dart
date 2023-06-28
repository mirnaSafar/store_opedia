import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit(this._postsRepository) : super(DeletePostInitial());
  final PostsRepository _postsRepository;
  Future deletePost({required String postID}) async {
    emit(DeletePostProgress());
    String response = await _postsRepository.deletePost(postID: postID);
    if (response == "Failed") {
      emit(DeletePostFailed(
          message:
              "Failed to delete the Post , Check your internet connection"));
    } else {
      emit(DeletePostSucceed());
    }
  }
}
