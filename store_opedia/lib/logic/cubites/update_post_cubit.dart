import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/update_post_repository.dart';

part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostRepository updatePostRepository;
  UpdatePostCubit(this.updatePostRepository) : super(UpdatePostInitial());

  Future deleteUser({required String id}) async {
    emit(UpdatePostProgress());
    String? response = await updatePostRepository.updatePost(id: id);
    if (response == "Failed") {
      emit(UpdatePostFailed(
          message:
              "Failed to Update the Post , Check your internet connection"));
    } else if (response == "Success") {
      emit(UpdatePostSucceed());
    }
  }
}
