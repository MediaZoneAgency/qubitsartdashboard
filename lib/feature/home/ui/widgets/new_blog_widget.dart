import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theming/styles.dart';

class AddNewBlogWidget extends StatelessWidget {
  const AddNewBlogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Container(
height: 164.h,
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(35.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add New Blog",
                style: TextStyles.lato17SemiBoldDarkWhite
              ),
            ),
            SizedBox(height: 8.h),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: TextFormField(
                style: const TextStyle(color:Colors.black),
                decoration: InputDecoration(
                  hintText: "add text",
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Action Buttons

          ],
        ),
      ),
    );
  }
}
