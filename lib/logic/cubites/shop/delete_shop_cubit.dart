import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_shop_state.dart';

class DeleteShopCubit extends Cubit<DeleteShopState> {
  DeleteShopCubit() : super(DeleteShopInitial());
}
