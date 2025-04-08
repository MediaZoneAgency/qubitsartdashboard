
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubitarts/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/sharedWidgets/app_text_button.dart';
import '../../../../core/sharedWidgets/app_text_form_field.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../widgets/enter_your.dart';


class ResetPassword extends StatefulWidget{
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isObscureNew = true;
  bool isObscureConfirm = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      backgroundColor: Colors.white,
        body:
        SafeArea(child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            Text('Change Password',style: TextStyles.lato28DarkBlackBold.copyWith(color: Color(0xff2A2A2A)),),
              verticalSpace(50),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   EnterYour(
                    text: S.of(context).EnterPassword,
              ),
              verticalSpace(7.88),
              AppTextFormField(
                    hintText: S.of(context).Password,
                    isObscureText: isObscureNew,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscureNew = !isObscureNew;
                          });
                        },
                        child: Icon(isObscureNew
                            ? Icons.visibility_off
                            : Icons.visibility)),
              ),
                 ],
               ),
              verticalSpace(23.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EnterYour(
                    text: 'Confirm Password',
                  ),
                  verticalSpace(7.88),
                  AppTextFormField(
                    hintText: 'Password',
                    isObscureText: isObscureConfirm,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isObscureConfirm = !isObscureConfirm;
                          });
                        },
                        child: Icon(isObscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ],
              ),
              verticalSpace(30.5),
              AppTextButton(
                backgroundColor: Color(0xff1B1B1B),
                borderRadius: 30.r,
                buttonHeight: 47.h,
                buttonWidth: 122.w,
                buttonText: 'Change', textStyle: TextStyles.lato18WhiteRegular, onPressed: () {
context.pushNamed(Routes.loginScreen);
              },)
          ],),
        )));
  }
}