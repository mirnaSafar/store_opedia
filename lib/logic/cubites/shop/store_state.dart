// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_cubit.dart';

class StoreState {}

class ShopsInitial extends StoreState {}

class ShopsFetchedSuccessfully extends StoreState {}

class ErrorFetchingShops extends StoreState {
  String message;
  ErrorFetchingShops({required this.message});
}

class NoShopsYet extends StoreState {}

class FeatchingShopsProgress extends StoreState {}

class OldestShopsFiltered extends StoreState {}

class DeleteShopProgress extends StoreState {}

class DeleteShopSucceed extends StoreState {}

class DeleteShopFailed extends StoreState {
  final String message;
  DeleteShopFailed({required this.message});
}

class UpdateShopProgress extends StoreState {}

class UpdateShopSucceed extends StoreState {}

class UpdateShopFailed extends StoreState {
  final String message;
  UpdateShopFailed({required this.message});
}

class AddShopProgress extends StoreState {}

class AddShopSucceed extends StoreState {}

class AddShopFailed extends StoreState {
  final String message;
  AddShopFailed({required this.message});
}
