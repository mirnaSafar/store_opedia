import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rate_shop_state.dart';

class RateShopCubit extends Cubit<RateShopState> {
  RateShopCubit() : super(RateShopInitial());
}
