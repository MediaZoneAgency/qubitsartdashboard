import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubitarts/core/theming/colors.dart';
import 'package:qubitarts/core/theming/styles.dart';

class CustomRequestWidget extends StatelessWidget {
  const CustomRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(66.r),
        color: ColorsManager.blue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Request",
                    style: TextStyles.inter22RegularWhite.copyWith(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        "28 Oct",
                        style: TextStyles.inter12LightWhite,
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        "11:11 pm",
                        style: TextStyles.inter12LightWhite,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: Column(
                children: [
                  Text(
                    "see all",
                    style: TextStyles.inter22RegularWhite.copyWith(fontSize: 20),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
