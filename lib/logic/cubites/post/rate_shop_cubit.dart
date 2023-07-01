import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/data/repositories/posts_repository.dart';
import 'package:shopesapp/data/repositories/shared_preferences_repository.dart';

part 'rate_shop_state.dart';

class RatePostCubit extends Cubit<RatePostState> {
  // String ownerId, shopId;
  RatePostCubit() : super(RatePostInitial(rate: 0
            //  SharedPreferencesRepository.getStoreRate(
            //     ownerId: ownerId, shopId: shopId)
            ));

  Future<void> setPostRating(
      {required double newRate,
      required String ownerId,
      required String shopId,
      required String postId}) async {
    if (newRate > 3.0) {
      String? response = await PostsRepository()
          .sendPostRating(ownerId, shopId, postId, newRate);

      SharedPreferencesRepository.setPostRate(
          ownerId: ownerId, shopId: shopId, rate: newRate, postId: postId);
      emit(RatePostState(rate: newRate));
      if (response == 'Success') {
        SharedPreferencesRepository.setPostRate(
            ownerId: ownerId, shopId: shopId, rate: newRate, postId: postId);
        emit(RatePostState(rate: newRate));
      } else {
        const ScaffoldMessenger(child: Text('Something went wrong!'));
      }
    }
  }

  double getPostRating(
      {required String ownerId,
      required String shopId,
      required String postId}) {
    return SharedPreferencesRepository.getPostRate(
        ownerId: ownerId, shopId: shopId, postId: postId);
    // state.rate;
  }
}
