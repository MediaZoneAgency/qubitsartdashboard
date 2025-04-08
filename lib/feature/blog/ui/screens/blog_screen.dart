import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:qubitarts/core/helpers/extensions.dart';
import 'package:qubitarts/core/helpers/spacing.dart';

import 'package:qubitarts/core/theming/colors.dart';
import 'package:qubitarts/feature/blog/logic/blog_cubit.dart';
import 'package:qubitarts/feature/home/ui/widgets/post_loader.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theming/styles.dart';

import '../../../../generated/l10n.dart';
import '../../../home/ui/widgets/blog_post.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  void didChangeDependencies() async {
    super.didChangeDependencies();
    BlogCubit.get(context).changeIndex(0);
    await BlogCubit.get(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Color(0xff1F1F1F),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0.h, bottom: 29.h),
              child: Image.asset(
                'assets/img/1-01 white 1.png',
                height: 40.h,
                width: 171.5.w,
              ),
            ),
            // Category Filter Bar
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 12.w, start: 14.w),
              height: 33.5.h,
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return horizontalSpace(8.w);
                  },
                  itemCount: BlogCubit.get(context).BlogCategories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        BlogCubit.get(context).changeIndex(index);
                        BlogCubit.get(context).fetchPostsByCategory();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        decoration: BoxDecoration(
                            color: BlogCubit.get(context).selectedIndex == index
                                ? ColorsManager.yellow
                                : Colors.white,
                            borderRadius: BorderRadius.circular(18.r)),
                        height: 33.5.h,
                        child: Center(
                            child: Text(
                          BlogCubit.get(context).BlogCategories[index],
                          style: TextStyles.roboto12RegularBlack,
                          textAlign: TextAlign.center,
                        )),
                      ),
                    );
                  }),
            ),
          //  Blog Post List
            BlocBuilder<BlogCubit, BlogState>(
              builder: (context, state) {
                if (state is BlogLoadingState &&
                    BlogCubit.get(context).posts.isEmpty) {
                  return const PostLoader();
                } else if (state is BlogErrorState) {
                  return const Text('There is an error, please try again');
                } else if (BlogCubit.get(context).posts.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      verticalSpace(170.h),
                      Text(
                        'No blogs found',
                        style: TextStyles.lato33BoldBlack,
                      ),
                      verticalSpace(10.h),
                      Text(
                        'no blog in this topic',
                        style: TextStyles.lato16MediumGray,
                      )
                    ],
                  );
                } else if (BlogCubit.get(context).posts.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0.w, vertical: 13.h),
                        child: BlogPostItem(
                          background: Colors.white,
                          title: BlogCubit.get(context).posts[index].postTitle,
                          description: BlogCubit.get(context)
                              .posts[index]
                              .postDescription,
                          image: BlogCubit.get(context).posts[index].postPhoto,
                          onTap: () {
                            // context.pushNamed(Routes.postDetails, arguments: {
                            //   'postModel': BlogCubit.get(context).posts[index],
                            //   'isLiked': BlogCubit.get(context).likes[index]
                            // });
                          },
                          isLiked: BlogCubit.get(context).likes.isEmpty
                              ? false
                              : BlogCubit.get(context).likes[index],
                          like: () {
                            BlogCubit.get(context).likes[index]
                                ? BlogCubit.get(context).disLikePost(index,
                                    BlogCubit.get(context).posts[index].id)
                                : BlogCubit.get(context).likePost(index,
                                    BlogCubit.get(context).posts[index].id);
                          },
                        ),
                      );
                    },
                    itemCount: BlogCubit.get(context).posts.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                  );
                }
                return Text('empty');
              },
            ),



          //   Padding(
          //   padding: EdgeInsetsDirectional.only(
          //       start: 130.w, top: 29.h, end: 16.w),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         S.of(context).QubitartsBlog,
          //         style: TextStyles.lato20BoldBlack,
          //       ),
          //       Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               // context.pushNamed(Routes.blog);
          //             },
          //             child: Text(
          //               S.of(context).SeeMore,
          //               style: TextStyles.lato12grayBold
          //                   .copyWith(color: const Color(0xff797979)),
          //             ),
          //           ),
          //           Icon(
          //             Icons.keyboard_arrow_right,
          //             color: const Color(0xff797979),
          //             size: 18.h,
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding:
          //   EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
          //   child: BlogPostItem(
          //     background: const Color(0xFFFFFFFF), title: 'blog', description: 'blog instgram', image: '', onTap: () {  }, isLiked: true, like: () {  },
          //   ),
          // ),
          ],
        ),
      );
    });
  }
}
