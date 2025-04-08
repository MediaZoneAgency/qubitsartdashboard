import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure it spans the width of the screen

      decoration: const BoxDecoration(
        image:  DecorationImage(
          image: AssetImage('assets/img/Screensho.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 300,
              right: 50.w,
              child:
          Column(
            children: [
          SizedBox(
            width: 700.w,
            height: 700.h,
            child: Image(image:AssetImage('assets/img/Group 37577.png'),
            fit: BoxFit.scaleDown,
            ),
          )
            ],

          )),
          // Add a gradient overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          // Positioned content (adjusted to avoid layout issues)
          Positioned(
            top: 150.h,
            left: 25.w,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).welcom,
                  style: TextStyles.inter24BoldWhite
                ),
                SizedBox(height: 8.h),
                Text(
                  S.of(context).QubitartsDashboard,
                    style: TextStyles.inter24BoldWhite
                ),
                SizedBox(height: 8.h),
                Text(
                    S.of(context).signinup,
                    style: TextStyles.inter12MediumLightGray
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
