part of 'rate_shop_cubit.dart';

class RateShopState {
  double rate;
  RateShopState({required this.rate});
}

class RateShopInitial extends RateShopState {
  RateShopInitial({required double rate}) : super(rate: rate);
}
