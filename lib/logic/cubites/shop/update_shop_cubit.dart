import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_shop_state.dart';

class UpdateShopCubit extends Cubit<UpdateShopState> {
  UpdateShopCubit() : super(UpdateShopInitial());
}
