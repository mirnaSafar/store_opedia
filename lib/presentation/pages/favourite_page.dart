import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/data/models/shop.dart';
import 'package:shopesapp/logic/cubites/post/post_favorite_cubit.dart';
import 'package:shopesapp/logic/cubites/shop/favorite_cubit.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/product/product_post.dart';
import 'package:shopesapp/presentation/widgets/suggested_store/suggested_store.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late TabController tabController;
  // late PostFavoriteCubit postFavoriteCubit;

  // late List<Post> favoritePostsList;
  @override
  void initState() {
    BlocListener<PostFavoriteCubit, PostFavoriteState>(
      listener: (context, state) {
        // postFavoriteCubit =
        //   context.read<PostFavoriteCubit>();
        // favoritePostsList = state.favoritePosts;
      },
    );
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
              return state.favoritePosts.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                      children: [
                        40.ph,
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.favoritePosts.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const CustomDivider();
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return ProductPost(
                                post:
                                    Post.fromJson(state.favoritePosts[index]));
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
              return state.favoriteShops.isNotEmpty
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
