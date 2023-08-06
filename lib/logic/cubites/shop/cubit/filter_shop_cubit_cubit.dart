import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filter_shop_cubit_state.dart';

class FilterShopCubitCubit extends Cubit<FilterShopCubitState> {
  FilterShopCubitCubit() : super(FilterShopCubitInitial());
}
