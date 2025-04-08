import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:qubitarts/core/helpers/extensions.dart';


import '../../../../core/theming/colors.dart';
import '../../../service_list/ui/screens/service_list.dart';
import '../../logic/nav_bar_cubit.dart';

class NavBarContainer extends StatelessWidget {
  const NavBarContainer({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Stack(
            children: [
              Container(
                width: 256.98.w,
                height: 58.h,
                margin: EdgeInsets.symmetric(horizontal: 68.w, vertical: 12.h),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: ColorsManager.dark80, blurRadius: 3.57)
                    ],
                    color: ColorsManager.dark80,
                    borderRadius: BorderRadius.circular(33.9.r)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      NavBarCubit.get(context).navIcon.length,
                      (index) {
                        final isSelected =
                            NavBarCubit.get(context).selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(index);
                            NavBarCubit.get(context).changeIndex(index);
                          },
                          child: Image.asset(
                            isSelected
                                ? NavBarCubit.get(context).navIconYellow[index]
                                : NavBarCubit.get(context).navIcon[index],
                            height: 25.h,
                            width: 25.w,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   left: 174.w,
              //   bottom: 34.h,
              //   child: Container(
              //     height: 45.h,
              //     width: 45.w,
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle, color: ColorsManager.white),
              //     child: IconButton(
              //       onPressed: () {
              //         showDialog(
              //             context: context,
              //             builder: (context) {
              //               return ServiceList();
              //             });
              //       },
              //       icon: Icon(Icons.add),
              //       color: Colors.black,
              //     ),
              //   ),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
