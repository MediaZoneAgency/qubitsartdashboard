import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubitarts/core/helpers/extensions.dart';
import 'package:qubitarts/core/helpers/spacing.dart';


import '../../../../core/routes/routes.dart';

import '../widgets/service_container.dart';
import '../widgets/website_container.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: NewServiceList(), // Use the widget here
    );
  }
}

class NewServiceList extends StatefulWidget {
  @override
  State<NewServiceList> createState() => _NewServiceListState();
}

class _NewServiceListState extends State<NewServiceList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0.w, sigmaY: 8.0.h),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              //you can change opacity with color here(I used black) for background.
              decoration:
                  BoxDecoration(color: Colors.transparent.withOpacity(0.0)),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WebsiteContainer(onTap: () {
           //   context.pushNamed(Routes.addWebsite);
            },),
            verticalSpace(16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomServiceContainer(title: 'Brand Identity', description: 'Lorem Ipsum is simply dummy text of the printing and \ntypesetting industry.', image:'assets/images/brandi.png', route: '',),
                CustomServiceContainer(title: 'Mobile Apps', description: 'Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.', image:'assets/images/mobile.png', route: Routes.settingsScreen,)

              ]),
            verticalSpace(16.h),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomServiceContainer(title: 'Digital Marketing', description: 'Lorem Ipsum is simply dummy text of the printing and \ntypesetting industry.', image:'assets/images/degital.png', route: Routes.searchScreen,),
                  const CustomServiceContainer(title: 'Motion Graphics', description: 'Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.', image:'assets/images/motion.png', route: '',)

                ]),
            verticalSpace(16.h),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomServiceContainer(title: 'Print Outs', description: 'Lorem Ipsum is simply dummy text of the printing and \ntypesetting industry.', image:'assets/images/printout.png', route: '',),
                  CustomServiceContainer(title: 'Motion Graphics', description: 'Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.', image:'assets/images/adcam.png', route: '',)

                ])
          ],
        )
      ],
    );
  }
}




