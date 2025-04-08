import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qubitarts/core/helpers/extensions.dart';

import 'package:qubitarts/feature/home/ui/widgets/start_progress.dart';


import '../../../../core/helpers/spacing.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import 'line_progress.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //Make sure this is installed


class ProjectCard extends StatelessWidget {
  final String id;
  final String title;
  final String startDate;
  final String status;
  final List<String> stages;
  final List<String> stageDates;


  const ProjectCard({
    Key? key,
    required this.id,
    required this.title,
    required this.startDate,
    required this.status,
    required this.stages,
    required this.stageDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // context.pushNamed(Routes.oneServiceDetails);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
        padding:  EdgeInsets.all(16),
        decoration: BoxDecoration(
          // boxShadow: [BoxShadow(blurRadius: 100,color: Color(0xffE2ECF5))],
          color: Color(0xffFEE567),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xff3276E8),
                  child: Text(
                    id,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lato(fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color:
                          Colors.black
                          ,),

                      ),


                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: Color(0xff363636)),
              ],
            ),
            SizedBox(height: 16.h),
            Row(children: [
              StartProgress(title:"Start Date:",startDate: startDate),
              SizedBox(width: 40.w), // horizontalSpace replacement
              StartProgress(title:"Status:",startDate: status)
            ],),

            LineProgress(progress: 0.7,valueColor: Colors.black,),
            SizedBox(height: 8.h), //Added to separate LineProgress from the next row
            TimelineRow(stages: stages, stageDates: stageDates),


          ],
        ),
      ),
    );
  }
}


class TimelineRow extends StatelessWidget {
  final List<String> stages;
  final List<String> stageDates;

  const TimelineRow({Key? key, required this.stages, required this.stageDates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.w,  //Match the parent size
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  //Remove, this messes up the Expands
        children: _buildStageContainers(),
      ),
    );
  }

  List<Widget> _buildStageContainers() {
    List<Widget> stageContainers = [];
    List<Color> stageColors = [Color(0xFF3276E8),  Color(0xFF8CB3D7),  Color(0xFFB9C9DA),Colors.white];

    for (int i = 0; i < stages.length; i++) {
      stageContainers.add(
        Expanded(
          flex: (i == 1) ? 3 : 2,  //Adjust flex,  "Development" is bigger
          child: Padding(
            padding: EdgeInsets.only(right: (i < stages.length - 1) ? 5.w : 0),  //Spacing only between elements
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: stageColors[i],
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Center(
                child: Text(
                  stages[i],
                  style:GoogleFonts.lato(color: (i == 3) ? Colors.black : Colors.white, fontSize: 7.sp),

                ),
              ),
            ),
          ),
        ),
      );
    }

     stageContainers.add(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Color(0xffD9D9D9),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {

              },
            ),
            IconButton(
              icon: Icon(Icons.keyboard_double_arrow_right),
              onPressed: () {

              },
            ),
          ],
        ),
      ));


    return stageContainers;
  }
}



class StartProgress extends StatelessWidget {
  final String title;
  final String startDate;
  const StartProgress({Key? key, required this.title, required this.startDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: GoogleFonts.lato(color: Colors.white,fontSize: 7.sp),),
        Text(startDate,style: GoogleFonts.lato(color: Colors.white,fontSize: 19.5.sp))
      ],
    );
  }
}

class LineProgress extends StatelessWidget {
  final double progress;
  final Color valueColor;
  const LineProgress({Key? key, required this.progress, required this.valueColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      width: 100.w,
      height: 4.h,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12)
      ),
      child: FractionallySizedBox(
        alignment: Alignment.topLeft,
        widthFactor: progress,
        heightFactor: 1,
        child: Container(
          decoration: BoxDecoration(
              color: valueColor,
              borderRadius: BorderRadius.circular(12)
          ),
        ),
      ),
    );
  }
}


class PinnedProjectCard extends StatelessWidget {
  final String id;
  final String title;
  final String startDate;
  final String status;
  final List<String> stages;
  final List<String> stageDates;
  final VoidCallback? ontap;
  final VoidCallback? ondecline;

  const PinnedProjectCard({

    Key? key,
    required this.ondecline,
    required this.ontap,
    required this.id,
    required this.title,
    required this.startDate,
    required this.status,
    required this.stages,
    required this.stageDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // context.pushNamed(Routes.oneServiceDetails);
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
            padding:  EdgeInsets.all(16),
            decoration: BoxDecoration(
              // boxShadow: [BoxShadow(blurRadius: 100,color: Color(0xffE2ECF5))],
              color: Color(0xff333435),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xff3276E8),
                      child: Text(
                        id,
                        style:GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                              Colors.white
                            ),
                          ),


                        ],
                      ),
                    ),
                    Icon(Icons.more_vert, color: Color(0xff363636)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(children: [
                  StartProgress(title:"Start Date:",startDate: startDate),
                  horizontalSpace(40.w),
                  StartProgress(title:"Status:",startDate: status)
                ],),

                LineProgress(progress: 0.7,valueColor: Colors.yellow,),
                Row(
                  children: [
                    SizedBox(
                      width: 260.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          stages.length,
                              (index) => Column(
                            children: [
                              Text(
                                stages[index],
                                style:  GoogleFonts.lato(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: index == 0 ? Colors.blue : Colors.grey,
                                ),
                              ),
                              Text(
                                stageDates[index],
                                style:  GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Container(
                    //  width: 77.w,
                    //  height: 31.h,
                    //  child: CircleAvatar(backgroundColor: Color(0xff76A5CF),child: Icon(Icons.edit,color: Colors.white,),),)
                  ],
                ),


              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              GestureDetector(
                onTap: ontap,
                child: Container(
                  height:40.h,
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 5.h),
                  width: 210.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color:  const Color(0xFF3276E8),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text("Confirm",
                    style: TextStyles.lato18WhiteRegular,
                  ),
                ),
              ),
              GestureDetector(
                onTap: ondecline,
                child: Container(
                  height:40.h,
                  width: 144.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color:  const Color(0xFFFF4141),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text("Decline",
                    style: TextStyles.lato18WhiteRegular,
                  ),
                ),
              ),



            ],
          )
        ],
      ),
    );
  }
}


