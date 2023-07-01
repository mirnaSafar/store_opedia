import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';

part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit(this._postsRepository) : super(UpdatePostInitial());
  final PostsRepository _postsRepository;
  Future updatePost(
      {required String postID,
      required String shopID,
      required String title,
      required String description,
      required String? postImages,
      required String category,
      required String productPrice}) async {
    String response = await _postsRepository.updatePost(
        postID: postID,
        shopID: shopID,
        title: title,
        description: description,
        postImages: postImages,
        category: category,
        productPrice: productPrice);
    if (response == "Failed") {
      emit(UpdatePostFailed(
          message:
              "Failed to Update the Post , Check your internet connection"));
    } else {
      emit(UpdatePostSucceed());
    }
  }
}
