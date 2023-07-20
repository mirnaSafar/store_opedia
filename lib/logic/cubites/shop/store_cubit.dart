import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/data/repositories/shop_repository.dart';
import 'package:shopesapp/logic/cubites/cubit/internet_cubit.dart';
import 'package:shopesapp/main.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  late Shop shop;
  List<dynamic> shops = [];
  List<dynamic> oldshops = [];
  StoreCubit() : super(ShopsInitial());
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
  //

  Future getAllStores() async {
    emit(FeatchingShopsProgress());
    Map<String, dynamic>? response;
    // try {
    response = await ShopRepository()
        .getAllStores(id: globalSharedPreference.getString("ID")!);
    /*  } catch (e) {
      emit(ErrorFetchingShops(
          message: response == null
              ? "Failed to Get the Stores , Check your internet connection"
              : response["message"]));
    }*/
    if (response == null) {
      emit(ErrorFetchingShops(
          message:
              "Failed to Get the Stores , Check your internet connection"));
    } else if (response["message"] != "Done" &&
        response["message"] != "No Stores Yet") {
      emit(NoShopsYet());
    } else if (response["message"] == "Done") {
      // print(response["stores"]);
      shops = response["stores"];
      emit(FeatchingShopsSucceed());
    } else {
      emit(ErrorFetchingShops(message: response["message"]));
    }
  }

//USE GET OWNER Shop Cubit insted this
  Future getOwnerShops(String ownerId) async {
    BlocListener<InternetCubit, InternetState>(
      listener: (context, state) async {
        if (state is InternetConnected) {
          Map<String, dynamic>? response =
              await ShopRepository().getOwnerShpos(ownerID: ownerId);
          if (response!["message"] == "Success") {
            shops = response["shops"];
            if (shops.isEmpty) {
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
    if (shops.isEmpty) {
      emit(NoShopsYet());
    } else {
      oldshops = List.from(shops.reversed);
      emit(OldestShopsFiltered());
    }
  }
}
