import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';

import '../../../../core/theming/styles.dart';
import '../../../home/ui/widgets/project_card.dart';
import '../../logic/current_services_cubit.dart';

class CurrentServiceScreen  extends StatelessWidget{
  const CurrentServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentServicesCubit, CurrentServicesState>(
  builder: (context, state) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0.h,bottom: 29.h),
          child: Image.asset('assets/img/agency.png',height: 40.h,width: 171.5.w,),
          
        ),
        Container(
          margin: EdgeInsetsDirectional.only(bottom: 12.w,start: 14.w),
          height: 33.5,
          child: ListView.separated(
              separatorBuilder: (context,index){return horizontalSpace(8.w);},
              itemCount:CurrentServicesCubit.get(context).currentServicesState.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    CurrentServicesCubit.get(context).changeIndex(index);
                  },
                  child: Container(
                    width: 89.w,
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(color:CurrentServicesCubit.get(context).selectedIndex==index? ColorsManager.primaryYellow:Color(0xffF8F8F8),borderRadius: BorderRadius.circular(18.r)),

                    height: 33.5.h,
                    child: Center(child: Text(CurrentServicesCubit.get(context).currentServicesState[index],style: TextStyles.roboto12RegularBlack.copyWith(fontSize: 10.5.sp),textAlign: TextAlign.center,)),
                  ),

                );
              }),
        ),
        ListView.builder(itemBuilder: (context,index){return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w,),
          child: const ProjectCard(
            id: "576",
            title: "Website Design System",
            startDate: "January 2024",
            status: "In progress",
            stages: ["UI UX", "Development", "Testing", "Publish"],
            stageDates: ["25/1", "30/1", "12/2", "25/3"],
          ),
        );},itemCount: 3,shrinkWrap: true,physics: ScrollPhysics())
    ],),);
  },
);
  }
}