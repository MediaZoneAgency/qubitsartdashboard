import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qubitarts/core/helpers/extensions.dart';
import 'package:qubitarts/feature/profile/data/model/user_model.dart';
import 'package:qubitarts/feature/profile/logic/profile_cubit.dart';

import '../../../../core/assets/images.dart';
import '../../../../core/routes/routes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';


class CustomHomeAppBar extends StatefulWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  State<CustomHomeAppBar> createState() => _CustomHomeAppBarState();
}

class _CustomHomeAppBarState extends State<CustomHomeAppBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ProfileCubit.get(context).fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Container(
          height: 90,
         width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(66.r),
              bottomLeft: Radius.circular(66.r),
              topLeft: Radius.circular(66.r),
              topRight: Radius.circular(66.r),
            ),
            color: Colors.white
          ),
          // margin:
          // EdgeInsetsDirectional.only(start: 18.w, top: 12.h, end: 25.w),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("Welcome ${ProfileCubit.get(context).user?.displayName ?? 'N/A'}.",
                      style:TextStyles.lato20BoldBlack,
                      ),
                    ),

                Spacer(),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 4.w),
                  child:  Image.asset("assets/img/Bell_pin_light.png"),
                  height: 46.h,
                  width: 46.w,
                ),

                GestureDetector(
                  onTap: () async {
                //   context.pushNamed(Routes.profile);
                   ProfileCubit.get(context).fetchUser();
                  },
                  child: CircleAvatar(
                    radius: 26.r,
                    child: Image.asset('assets/img/person1.png'),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}