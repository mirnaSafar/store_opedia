import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switch_shop_state.dart';

class SwitchShopCubit extends Cubit<SwitchShopState> {
  SwitchShopCubit() : super(SwitchShopInitial());
}
