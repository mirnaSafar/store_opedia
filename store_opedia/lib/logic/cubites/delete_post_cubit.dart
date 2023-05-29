import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/delete_post_repository.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostRepository deletePostRepository;
  DeletePostCubit(this.deletePostRepository) : super(DeletePostInitial());

  Future deletePost() async {
    emit(DeletePostProgress());
    String response = await deletePostRepository.deletePost(id: "");
    if (response == "Failed") {
      emit(DeletePostFailed(
          message:
              "Failed to delet the Post , Check your internet connection"));
    } else {
      emit(DeletePostSucceed());
    }
  }
}
