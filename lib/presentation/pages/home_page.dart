import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:shopesapp/logic/cubites/post/filter_cubit.dart';
import 'package:shopesapp/presentation/location_service.dart';
import 'package:shopesapp/presentation/pages/map_page.dart';
import 'package:shopesapp/presentation/shared/colors.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_text.dart';
import 'package:shopesapp/presentation/shared/extensions.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/product/product_post.dart';
import 'package:shopesapp/presentation/widgets/switch_shop/error.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (postsList.isEmpty) {
      context.read<FilterCubit>().getAllPosts();
    }
  }

  List<dynamic> postsList = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        //online
        context.read<FilterCubit>().getAllPosts();

        // await context.read<PostsCubit>().getOwnerPosts(
        //     ownerID: globalSharedPreference.getString("ID")!,
        //     shopID: globalSharedPreference.getString("shopID")!);
      },
      // child: BlocListener<InternetCubit, InternetState>(
      //   listener: (context, state) async {
      //     if (state is InternetConnected) {
      //       context.read<PostsCubit>().getPosts();
      //     } else if (state is InternetDisconnected) {
      //     } else {
      //       const CircularProgressIndicator();
      //     }
      //   },
      child: Scaffold(
        backgroundColor: AppColors.mainWhiteColor,
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: PageHeader(),
            ),
            BlocBuilder<FilterCubit, FilterState>(builder: (context, state) {
              // online
              if (state is FilterProgress) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is NoPostYet) {
                return const Center(child: CustomText(text: 'no posts '));
              } else if (state is FilteredSuccessfully) {
                postsList = BlocProvider.of<FilterCubit>(context).filteredPosts;

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: postsList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const CustomDivider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ProductPost(
                      post: postsList[index],
                    );
                  },
                );
              }
              return InkWell(
                  onTap: () async {
                    // LocationService().getCurrentAddressInfo();
                    LocationData? currentLocation =
                        await LocationService().getUserCurrentLocation();
                    if (currentLocation != null) {
                      context.push(MapView(currentLocation: currentLocation));
                    }
                  },
                  child: buildError(size));

              // return ListView.separated(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: postsList.length,
              //   separatorBuilder: (BuildContext context, int index) {
              //     return const CustomDivider();
              //   },
              //   itemBuilder: (BuildContext context, int index) {
              //     return ProductPost(
              //       post: postsList[index],
              //     );
              //   },
              // );
            }
                //else if(state is ErrorFetchingPosts){
                // return Center(child: CustomText( text:  ErrorFetchingPosts.message,))
                //}
                // }
                // },
                ),
          ],
        ),
      ),
      // ),
    );
  }
}
