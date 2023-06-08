import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_shop_posts_state.dart';

class GetShopPostsCubit extends Cubit<GetShopPostsState> {
  GetShopPostsCubit() : super(GetShopPostsInitial());
}
