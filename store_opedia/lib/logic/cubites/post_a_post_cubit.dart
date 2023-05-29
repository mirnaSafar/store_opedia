import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/post_a_post.dart';

part 'post_a_post_state.dart';

class PostAPostCubit extends Cubit<PostAPostState> {
  PostAPostRepository postAPostRepository;
  PostAPostCubit(this.postAPostRepository) : super(PostAPostInitial());

  Future postAPost({id: ""}) async {
    emit(PostAPostProgress());
    String? response = await postAPostRepository.postAPost(id: "");
    if (response == "Failed") {
      emit(PostAPostFailed(
          message: "Failed to Post the Post , Check your internet connection"));
    } else {
      emit(PostAPostSucceed());
    }
  }
}
