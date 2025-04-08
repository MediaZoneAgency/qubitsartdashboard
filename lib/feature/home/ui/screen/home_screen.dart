import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:qubitarts/feature/home/logic/home_cubit.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../profile/logic/profile_cubit.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_request_widget.dart';
import '../widgets/custom_switch_state.dart';
import '../widgets/new_blog_widget.dart';
import '../widgets/project_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of button labels
  final List<String> buttonLabels = ["Pending", "Approved", "InProgress", "Done"];

  // Currently selected button index
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).fetchUser();
    HomeCubit.get(context).fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeLoaded) {
          return Scaffold(
            backgroundColor: const Color(0xff1C1C1C),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHomeAppBar(),
                  SizedBox(height: 16.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomRequestWidget(),

                        Positioned(
                          top: 100 ,
                          left: 16,
                          right: 16,
                          child: ProjectCard(
                            id:  "N/A",
                            title: state.requests[0].type ?? "No Type",
                            startDate: "Unknown",
                            status: state.requests[0].status ?? "Pending",
                            stages: ["Ui Ux", "Development", "Testing", "Publish"],
                            stageDates: ["2024-01-05", "2024-01-15", "2024-01-22", "2024-01-29"],
                          ),
                        ),
                      const Positioned(
                        top: 300,
                        left: 16,
                        right: 16,
                        child: AddNewBlogWidget(),
                      ),
                      Positioned(
                        top: 400,
                        left: 25,
                        right: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
                          child: Container(
                            width: 325.w,
                            decoration: BoxDecoration(
                              color: const Color(0xff363636),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff363636),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    elevation: 0,
                                  ),
                                  icon: const Icon(
                                    LucideIcons.image,
                                    color: Color(0xffFF6B6B),
                                  ),
                                  label: Text(
                                    "Image/Video",
                                    style: TextStyle(color: const Color(0xffFF6B6B), fontSize: 12.sp),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff363636),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                    elevation: 0,
                                  ),
                                  icon: const Icon(
                                    LucideIcons.link,
                                    color: Color(0xffFF6B6B),
                                  ),
                                  label: Text(
                                    "Add Link",
                                    style: TextStyle(color: const Color(0xffFF6B6B), fontSize: 12.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(320.h),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                             height: 40.h,
              decoration: BoxDecoration(
                color: const Color(0xff1E1E1E),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(buttonLabels.length, (index) {
                    return _buildButton(
                      label: buttonLabels[index],
                      isSelected: selectedIndex == index,
                      onTap: () => setState(() {
                        selectedIndex = index;
                        HomeCubit.get(context).fetchRequestsByStatus( buttonLabels[index]);// Update the selected index
                      }),
                    );
                  }),
                ),
              ),
            ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 8.h), // مسافة بين الكروت
                        itemCount: HomeCubit.get(context).requestsbystatus.length,
                        itemBuilder: (context, index) {
                          var request = HomeCubit.get(context).requestsbystatus[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h), // مسافة بين الكروت
                            child: PinnedProjectCard(
                              id: index.toString()??"",
                              title: request.type ?? "No Type",
                              startDate: "Unknown",
                              status: request.status ?? "Pending",
                              stages: request.platforms ?? [],
                              stageDates: request.paidCampaigns ?? [],
                              ondecline: () {
                                HomeCubit.get(context).updateRequestStatus(request.id!, "declined");
                              },
                              ontap: () {
                                HomeCubit.get(context).updateRequestStatus(request.id!, "In Progress");
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),


                  verticalSpace(200.h),
                ],
              ),
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          return Container();
        }
      },
    );
  }
  Widget _buildButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32.h,
        width: 100.w,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF2CF00) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch user profile when the screen initializes
//     ProfileCubit.get(context).fetchUser();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff1C1C1C),
//       body: ListView(
//         children: [
//           const CustomHomeAppBar(),
//           // Padding(
//           //   padding: EdgeInsetsDirectional.only(
//           //       start: 20.0.w, top: 29.h, bottom: 20.h),
//           //   child: BlocBuilder<ProfileCubit, ProfileState>(
//           //     builder: (context, state) {
//           //       if (state is ProfileLoadingState) {
//           //         return  ProfileLoader();
//           //       }
//           //       if (state is ProfileErrorState) {
//           //         return const Text(
//           //           'Failed to load profile data. Please try again.',
//           //           style: TextStyle(color: Colors.white),
//           //         );
//           //       }
//           //       if (state is ProfileSuccessState) {
//           //         final user = ProfileCubit.get(context).user;
//           //         return HelloContainer(
//           //           name: user?.displayName ?? 'Guest',
//           //         );
//           //       }
//           //       return Container();
//           //     },
//           //   ),
//           // ),
//           const CustomRequestWidget(),
//           verticalSpace(10.h),
//           // AppTextFormField(
//           //   enabledBorder: OutlineInputBorder(
//           //     borderSide: const BorderSide(
//           //       color: Color(0xff2C2C2C),
//           //       width: 1.3,
//           //     ),
//           //     borderRadius: BorderRadius.circular(50.0.r),
//           //   ),
//           //   hintText: 'Search for anything',
//           //   suffixIcon: Image.asset(
//           //     'assets/img/Search_light.png',
//           //     width: 20.w,
//           //     height: 25.h,
//           //   ),
//           //   backgroundColor: const Color(0xff2C2C2C),
//           //   hintStyle: TextStyles.inter16RegularWhite,
//           // ),
//
//           verticalSpace(12.h),
//           Padding(
//             padding:
//             EdgeInsets.symmetric(horizontal: 73.w, vertical: 16.h),
//             child: const CustomSwitchState(),
//           ),
//           // Example Project Cards
//           ProjectCard(
//             id: "576",
//             title: "Website Design System",
//             startDate: "January 2024",
//             status: "In progress",
//             stages: ["UI UX", "Development", "Testing", "Publish"],
//             stageDates: ["25/1", "30/1", "12/2", "25/3"],
//           ),
//           ProjectCard(
//             id: "577",
//             title: "Mobile App Development",
//             startDate: "February 2024",
//             status: "In progress",
//             stages: ["Planning", "Design", "Coding", "Launch"],
//             stageDates: ["1/2", "15/2", "1/3", "10/3"],
//           ),
//           // Blog Section
//           Padding(
//             padding: EdgeInsetsDirectional.only(
//                 start: 130.w, top: 29.h, end: 16.w),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   S.of(context).QubitartsBlog,
//                   style: TextStyles.lato20BoldBlack,
//                 ),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // context.pushNamed(Routes.blog);
//                       },
//                       child: Text(
//                         S.of(context).SeeMore,
//                         style: TextStyles.lato12grayBold
//                             .copyWith(color: const Color(0xff797979)),
//                       ),
//                     ),
//                     Icon(
//                       Icons.keyboard_arrow_right,
//                       color: const Color(0xff797979),
//                       size: 18.h,
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding:
//             EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
//             child: const BlogPostItem(
//               background: Color(0x80f2f2f2),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 10.0.h),
//             child: Center(
//               child: Text(
//                 'Our Services',
//                 style: TextStyles.lato33BoldBlack,
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding:
//           //   EdgeInsets.symmetric(horizontal: 73.w, vertical: 16.h),
//           //   child: const CustomSwitchState(),
//           // ),
//           // // Example Project Cards
//           // ProjectCard(
//           //   id: "576",
//           //   title: "Website Design System",
//           //   startDate: "January 2024",
//           //   status: "In progress",
//           //   stages: ["UI UX", "Development", "Testing", "Publish"],
//           //   stageDates: ["25/1", "30/1", "12/2", "25/3"],
//           // ),
//           // ProjectCard(
//           //   id: "577",
//           //   title: "Mobile App Development",
//           //   startDate: "February 2024",
//           //   status: "In progress",
//           //   stages: ["Planning", "Design", "Coding", "Launch"],
//           //   stageDates: ["1/2", "15/2", "1/3", "10/3"],
//           // ),
//           // // Blog Section
//           // Padding(
//           //   padding: EdgeInsetsDirectional.only(
//           //       start: 130.w, top: 29.h, end: 16.w),
//           //   child: Row(
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Text(
//           //         S.of(context).QubitartsBlog,
//           //         style: TextStyles.lato20BoldBlack,
//           //       ),
//           //       Row(
//           //         children: [
//           //           GestureDetector(
//           //             onTap: () {
//           //               // context.pushNamed(Routes.blog);
//           //             },
//           //             child: Text(
//           //               S.of(context).SeeMore,
//           //               style: TextStyles.lato12grayBold
//           //                   .copyWith(color: const Color(0xff797979)),
//           //             ),
//           //           ),
//           //           Icon(
//           //             Icons.keyboard_arrow_right,
//           //             color: const Color(0xff797979),
//           //             size: 18.h,
//           //           )
//           //         ],
//           //       )
//           //     ],
//           //   ),
//           // ),
//           // Padding(
//           //   padding:
//           //   EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
//           //   child: const BlogPostItem(
//           //     background: Color(0x80f2f2f2),
//           //   ),
//           // ),
//           // Padding(
//           //   padding: EdgeInsets.only(top: 10.0.h),
//           //   child: Center(
//           //     child: Text(
//           //       'Our Services',
//           //       style: TextStyles.lato33BoldBlack,
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
// class HomeCard extends StatelessWidget {
//   const HomeCard(
//       {super.key,
//         required this.title,
//         required this.image,
//         required this.background,
//         this.width,
//         required this.onTap});
//   final String title;
//   final String image;
//   final Color background;
//   final double? width;
//   final Function() onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         //height: 293.h,
//           width: width,
//           padding: EdgeInsetsDirectional.only(top: 2.5.h),
//           decoration: BoxDecoration(
//               color: background,
//               image: DecorationImage(
//                   image: AssetImage('assets/images/shadowbackground.png'),
//                   fit: BoxFit.fill),
//               borderRadius: BorderRadius.circular(50.r)),
//           child: Column(
//             //crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/Frame.png',
//                   width: 36.w,
//                   height: 3.5.h,
//                 ),
//                 verticalSpace(14.h),
//                 Text(
//                   title,
//                   style: TextStyles.workSans21SemiBoldWhite
//                       .copyWith(color: Colors.black, fontSize: 24.sp),
//                 ),
//                 verticalSpace(13.h),
//                 Image.asset(
//                   image,
//                   fit: BoxFit.fill,
//                 )
//               ])),
//     );
//   }
// }
//
// class MobileHomeCard extends StatelessWidget {
//   const MobileHomeCard({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
// //height: 293.h,
//       width: 170.w,
//       padding: EdgeInsetsDirectional.only(start: 16.w, end: 14.w, top: 2.5.h),
//       decoration: BoxDecoration(
//           color: Color(0xffFEDC32),
//           image: DecorationImage(
//               image: AssetImage('assets/images/shadowbackground.png'),
//               fit: BoxFit.fill),
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(45.r),
//             topLeft: Radius.circular(45.r),
//             bottomLeft: Radius.circular(45.r),
//           )),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/Frame.png',
//             width: 36.w,
//             height: 3.5.h,
//           ),
//           verticalSpace(14.h),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               "Mobile\nApp",
//               style: TextStyles.workSans21SemiBoldWhite,
//             ),
//           ),
//           verticalSpace(13.h),
//           Image.asset(
//             'assets/images/mobileapp.png',
//             height: 202.h,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class serviceHomeCard extends StatelessWidget {
//   const serviceHomeCard({
//     super.key,
//     required this.title,
//     required this.image,
//     required this.background,
//     this.padding,
//   });
//   final String title;
//   final String image;
//   final Color background;
//   final EdgeInsetsGeometry? padding;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
// //height: 293.h,
//       width: 170.w,
//       padding: padding,
//       decoration: BoxDecoration(
//           color: background,
//           image: DecorationImage(
//               image: AssetImage('assets/images/shadowbackground.png'),
//               fit: BoxFit.fill),
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(45.r),
//             bottomRight: Radius.circular(45.r),
//             bottomLeft: Radius.circular(45.r),
//           )),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/Frame.png',
//             width: 36.w,
//             height: 3.5.h,
//           ),
//           verticalSpace(14.h),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Text(
//               title,
//               style: TextStyles.workSans21SemiBoldWhite,
//             ),
//           ),
//           verticalSpace(13.h),
//           Image.asset(
//             image,
//           )
//         ],
//       ),
//     );
//   }
// }