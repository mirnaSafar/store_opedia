import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';
import 'package:shopesapp/logic/cubites/cubit/internet_cubit.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  late Shop shop;
  late List<Shop> shopsResponse, _oldestShops;
  // final String ownerId;

  // Future<void> getOwnerStoreById(String ownerID, String shopID) async {
  //   Map<String, dynamic>? response =
  //       await ShopRepository().getShopById(ownerID: ownerID, shopID: shopID);

  //   if (response!["message"] == "Success") {
  //     shop = response["shop"] as Shop;
  //     if (shopsResponse.isEmpty) {
  //       emit(NoShopsYet() );
  //     } else {
  //       emit(ShopsFetchedSuccessfully() );
  //       // return shopsResponse;
  //     }
  //   } else {
  //     emit(ErrorFetchingShops(message: response["message"]) );
  //   }
  // }

  StoreCubit() : super(StoreState());

  Future getOwnerShops(String ownerId) async {
    BlocListener<InternetCubit, InternetState>(
      listener: (context, state) async {
        if (state is InternetConnected) {
          Map<String, dynamic>? response =
              await ShopRepository().getOwnerShpos(ownerID: ownerId);
          if (response!["message"] == "Success") {
            shopsResponse = response["shops"];
            if (shopsResponse.isEmpty) {
              emit(NoShopsYet());
            } else {
              emit(ShopsFetchedSuccessfully());
              // return shopsResponse;
            }
          } else {
            emit(ErrorFetchingShops(message: response["message"]));
          }
        } else if (state is InternetDisconnected) {
          const Center(
              child: CustomText(
            text: 'No Internet Connected',
          ));
        } else {
          const CircularProgressIndicator();
        }
      },
    );
    emit(FeatchingShopsProgress());
  }

  Future getOldestShops() async {
    emit(FeatchingShopsProgress());
    if (shopsResponse.isEmpty) {
      emit(NoShopsYet());
    } else {
      _oldestShops = List.from(shopsResponse.reversed);
      emit(OldestShopsFiltered());
    }
  }

  Future deleteShop({required String shopID}) async {
    emit(DeleteShopProgress());
    String response = await ShopRepository().deleteShop(shopID: shopID);
    if (response == "Failed") {
      emit(DeleteShopFailed(
          message:
              "Failed to delete the Shop , Check your internet connection"));
    } else {
      emit(DeleteShopSucceed());
    }
  }

  Future updateShop(
      {required String shopID,
      required String shopName,
      required String shopDescription,
      required String? shopProfileImage,
      required String? shopCoverImage,
      required String shopCategory,
      required String location,
      required String startWorkTime,
      required String shopPhoneNumber,
      required String endWorkTime,
      required List<String> socialUrl}) async {
    String response = await ShopRepository().updateShop(
        shopID: shopID,
        shopName: shopName,
        shopPhoneNumber: shopPhoneNumber,
        shopDescription: shopDescription,
        shopProfileImage: shopProfileImage,
        shopCoverImage: shopCoverImage,
        shopCategory: shopCategory,
        location: location,
        startWorkTime: startWorkTime,
        endWorkTime: endWorkTime,
        socialUrl: socialUrl);
    if (response == "Failed") {
      emit(UpdateShopFailed(
          message:
              "Failed to Update the Shop , Check your internet connection"));
    } else {
      emit(UpdateShopSucceed());
    }
  }

  Future addShop({
    required Map<String, dynamic> owner,
    required String shopName,
    required String shopDescription,
    required String? shopProfileImage,
    required String? shopCoverImage,
    required String shopCategory,
    required String location,
    required String endWorkTime,
    required String startWorkTime,
    required List<String> socialUrl,
    required String shopPhoneNumber,
  }) async {
    emit(AddShopProgress());
    String response = await ShopRepository().addShop(
        owner: owner,
        shopName: shopName,
        shopDescription: shopDescription,
        shopProfileImage: shopProfileImage,
        shopCoverImage: shopCoverImage,
        shopCategory: shopCategory,
        location: location,
        endWorkTime: endWorkTime,
        startWorkTime: startWorkTime,
        shopPhoneNumber: shopPhoneNumber,
        socialUrl: socialUrl);

    if (response == "Failed") {
      emit(AddShopFailed(
          message: "Failed to Add the Shop , Check your internet connection"));
    } else {
      emit(AddShopSucceed());
    }
  }
}
