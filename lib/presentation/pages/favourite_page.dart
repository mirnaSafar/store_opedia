import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/logic/cubites/shop/cubit/show_favorite_stores_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/favorite_cubit.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/product/product_post.dart';
import 'package:shopesapp/presentation/widgets/suggested_store/suggested_store.dart';

import '../../data/repositories/shared_preferences_repository.dart';
import '../../logic/cubites/post/cubit/show_favorite_posts_cubit.dart';
import '../../logic/cubites/post/post_favorite_cubit.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late TabController tabController;
  // late PostFavoriteCubit postFavoriteCubit;

  late List favoritePostsList = SharedPreferencesRepository.getFavoritePosts();
  late List favoriteStoresList =
      SharedPreferencesRepository.getFavoriteStores();
  @override
  void initState() {
    if (favoritePostsList.isEmpty) {
      context.read<ShowFavoritePostsCubit>();
      BlocConsumer<ShowFavoritePostsCubit, ShowFavoritePostsState>(
        listener: (context, state) {
          if (state is ShowFavoritePostsSuccessed) {
            favoritePostsList = state.favoritePosts;
            SharedPreferencesRepository.setFavoritePosts(
                favoritePostsList: favoritePostsList);
          }
        },
        builder: (context, state) {
          return BlocBuilder<ShowFavoritePostsCubit, ShowFavoritePostsState>(
            builder: (context, state) {
              if (state is ShowFavoritePostsProgress) {
                return const CircularProgressIndicator();
              }
              // if (state is ShowFavoritePostsSuccessed) {
              //   favoritePostsList = state.favoritePosts;
              //   return SingleChildScrollView(
              //       child: Column(
              //     children: [
              //       40.ph,
              //       ListView.separated(
              //         physics: const NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         itemCount: favoritePostsList.length,
              //         separatorBuilder: (BuildContext context, int index) {
              //           return const CustomDivider();
              //         },
              //         itemBuilder: (BuildContext context, int index) {
              //           return ProductPost(
              //               post: Post.fromJson(state.favoritePosts[index]));
              //         },
              //       ),
              //     ],
              //   ));
              // }
              if (state is NoFavoritePosts) {
                return const Center(
                  child: CustomText(text: 'No Favorite Posts Yet'),
                );
              }
              return const Center(
                child: Text(
                    'some thing went wrong,\ncheck your internet connection and try again'),
              );
            },
          );
        },
      );
    }
    if (favoriteStoresList.isEmpty) {
      context.read<ShowFavoriteStoresCubit>();
      BlocBuilder<ShowFavoriteStoresCubit, ShowFavoriteStoresState>(
        builder: (context, state) {
          if (state is ShowFavoriteStoresProgress) {
            return const CircularProgressIndicator();
          }
          if (state is ShowFavoriteStoresSuccessed) {
            favoriteStoresList = state.favoriteStores;
            return SingleChildScrollView(
                child: Column(
              children: [
                40.ph,
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favoriteStoresList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const CustomDivider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ProductPost(
                        post: Post.fromJson(favoriteStoresList[index]));
                  },
                ),
              ],
            ));
          }
          if (state is NoFavoritePosts) {
            return const Center(
              child: CustomText(text: 'No Favorite Posts Yet'),
            );
          }
          return const Center(
            child: Text(
                'some thing went wrong,\ncheck your internet connection and try again'),
          );
        },
      );
    }

    super.initState();
    tabController = TabController(length: 2, vsync: TickerProviderImpl());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(
            child: CustomText(text: 'Favorite Products'),
          ),
          Tab(
            child: CustomText(text: 'Favorite Stores'),
          ),
        ]),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          BlocBuilder<PostFavoriteCubit, PostFavoriteState>(
            builder: (context, state) {
              favoritePostsList = state.favoritePosts;
              return favoritePostsList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                      children: [
                        40.ph,
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: favoritePostsList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const CustomDivider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ProductPost(
                                post: Post.fromJson(favoritePostsList[index]));
                          },
                        ),
                      ],
                    ))
                  : const Center(
                      child: CustomText(text: 'No Favorite Posts Yet'),
                    );
            },
          ),
          BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              favoriteStoresList = state.favoriteShops;
              return favoriteStoresList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                      children: [
                        30.ph,
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.favoriteShops.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const CustomDivider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return SuggestedStore(
                                shop:
                                    Shop.fromJson(state.favoriteShops[index]));
                          },
                        ),
                      ],
                    ))
                  : const Center(
                      child: CustomText(text: 'No Favorite Stores Yet'),
                    );
            },
          ),
          // Text('data'),
          // Text('data'),
        ],
      ),
    );
  }
}
