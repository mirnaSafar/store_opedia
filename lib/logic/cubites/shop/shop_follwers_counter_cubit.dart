import 'package:bloc/bloc.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';

part 'shop_follwers_counter_state.dart';

class ShopFollwersCounterCubit extends Cubit<ShopFollwersCounterState> {
  ShopFollwersCounterCubit() : super(ShopFollwersCounterInitial(0, null));
  // late int shop.followesNumber!;
  void incrementFollowers(Shop shop) {
    // shop.followesNumber! = state.shopFollowersCounter + 1;
    shop.followesNumber = shop.followesNumber! + 1;

    SharedPreferencesRepository.setStoreFollowers(
      shop.followesNumber!,
      shop,
    );
    // shop.followesNumber = shop.followesNumber!;
    emit(ShopFollwersCounterState(shop.followesNumber!, shop));
  }

  void decrementFollowers(Shop shop) {
    shop.followesNumber! > 0
        ? shop.followesNumber = shop.followesNumber! - 1
        : shop.followesNumber = 0;

    SharedPreferencesRepository.setStoreFollowers(
      shop.followesNumber!,
      shop,
    );
    // shop.followesNumber = shop.followesNumber!;

    emit(ShopFollwersCounterState(shop.followesNumber!, shop));
  }

  int getShopFollwersCount(Shop shop) {
    return SharedPreferencesRepository.getStoreFollowers(shop);
  }
}
