import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit() : super(GetPostsInitial());
}
