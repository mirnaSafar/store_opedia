import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopesapp/logic/cubites/cubit/posts_cubit.dart';
import 'package:shopesapp/presentation/shared/custom_widgets/custom_divider.dart';
import 'package:shopesapp/presentation/widgets/page_header/page_header.dart';
import 'package:shopesapp/presentation/widgets/product/product_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        //online
        //  await context.read<PostsCubit>().getPosts();
      },
      child: Scaffold(
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: PageHeader(),
            ),
            BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                //online
                //   if (state is FeatchingPostsProgress) {
                //     return const Center(child: CircularProgressIndicator());
                // } else if(state is PostsFetchedSuccessfully){
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  separatorBuilder: (BuildContext context, int index) {
                    return const ProductPost();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return const CustomDivider();
                  },
                );
                //else if(state is ErrorFetchingPosts){
                // return Center(CustomText( ErrorFetchingPosts.message))
                //}
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
