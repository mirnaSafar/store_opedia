import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/post/filter_cubit.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/product/product_post.dart';
import 'package:shopesapp/presentation/widgets/switch_shop/error.dart';
import '../../data/enums/message_type.dart';
import '../../data/models/post.dart';
import '../../data/repositories/shared_preferences_repository.dart';
import '../../logic/cubites/cubit/internet_cubit.dart';
import '../shared/custom_widgets/custom_toast.dart';
import '../widgets/home/no_Internet.dart';
import '../widgets/home/no_posts_yet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> postsList = [];
  @override
  void initState() {
    super.initState();

    if (postsList.isEmpty) {
      context.read<FilterCubit>().getAllPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FilterCubit>().getAllPosts();
      },

      child: Scaffold(
        body: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetDisconnected) {
              CustomToast.showMessage(
                  context: context,
                  size: size,
                  message: "Interne Disconnected",
                  messageType: MessageType.REJECTED);
            }
          },
          builder: (context, state) {
            if (state is InternetDisconnected) {
              return buildNoInternet(size);
            }

            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: PageHeader(),
                ),
                (SharedPreferencesRepository.getBrowsingPostsMode())
                    ? buildError(size)
                    : BlocBuilder<FilterCubit, FilterState>(
                        builder: (context, state) {
                        if (state is FilterProgress) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is NoPostYet) {
                          //  print("selected");
                          return buildNoPostsYet(size,
                              "NO Posts Yet , Follow Stores to Show Posts");
                        } else if (state is DontFollowStoreYet) {
                          //  print("selected");
                          return buildNoPostsYet(
                              size, "You dont have any followed store yet");
                        } else if (state is FilteredSuccessfully) {
                          postsList = BlocProvider.of<FilterCubit>(context)
                              .filteredPosts;

                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: postsList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.01),
                                  child: const Divider(
                                    thickness: 7,
                                  ));
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return ProductPost(
                                post: Post.fromMap(postsList[index]),
                                // shop: Shop.fromJson(
                                //     BlocProvider.of<FollowingCubit>(context)
                                //         .updatedFollowedShops
                                //         .firstWhere(
                                //           (element) =>
                                //               Post.fromMap(postsList[index])
                                //                       .ownerID ==
                                //                   Shop.fromJson(element)
                                //                       .ownerID &&
                                //               Post.fromMap(postsList[index])
                                //                       .shopeID ==
                                //                   Shop.fromJson(element).shopID,
                                //         )),
                              );
                            },
                          );
                        }
                        /*    if (!SharedPreferencesRepository
                            .getBrowsingPostsMode()) {
                          return buildNoPostsYet(
                              "You Can't Follow Store Yet \n Pleas Create one now or login  befor",
                              size);
                        }*/
                        return buildError(size);
                      }),
              ],
            );
          },
        ),
      ),
      // ),
    );
  }
}
