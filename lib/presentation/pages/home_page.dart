import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/data/models/post.dart';
import 'package:shopesapp/logic/cubites/post/posts_cubit.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/product/product_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> postsList = [
    Post(
        title: "headline1",
        description: "description",
        category: "category",
        ownerID: "ownerID1",
        ownerName: "ownerName",
        ownerPhoneNumber: "ownerPhoneNumber",
        price: "price",
        postImage: "postImage",
        shopeID: "shopeID1",
        postID: "postID1"),
    Post(
        title: "post4",
        description: "description",
        category: "category",
        ownerID: "ownerID2",
        ownerName: "ownerName",
        ownerPhoneNumber: "ownerPhoneNumber",
        price: "price",
        postImage: "postImage",
        shopeID: "shopeID2",
        postID: "postID1")
  ];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        //online
        //  await context.read<PostsCubit>().getPosts();
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
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: PageHeader(),
            ),
            BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
              //online
              //   if (state is FeatchingPostsProgress) {
              //     return const Center(child: CircularProgressIndicator());
              // } else if(state is PostsFetchedSuccessfully){
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
