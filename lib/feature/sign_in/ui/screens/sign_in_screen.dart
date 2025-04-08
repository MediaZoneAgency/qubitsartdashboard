import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qubitarts/core/helpers/extensions.dart';
import 'package:qubitarts/core/sharedWidgets/app_text_form_field.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/sharedWidgets/app_text_button.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../logic/login_cubit.dart';
import '../widgets/background_container.dart';
import '../widgets/login_States.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
    return Scaffold(

      body: Stack(
        children: [
          // Background Widget
          BackgroundWidget(),
          // Foreground Content
          Positioned(
            top: 215,
            child: Container(
              height:MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width, // Set width to screen width
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Adjust size to content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 15.h,),
                          Text(S.of(context).Login,style: TextStyles.inter25SemiBoldDark,),
                          SizedBox(height: 20,),
                          AppTextFormField(

                            labeltext: S.of(context).Email ,
                            controller: _emailController,
                            borderRadius:32,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            prefexIcon:SvgPicture.asset(
                              'assets/img/fi_646094.svg',
                              fit:  BoxFit.scaleDown,
                            ),
                            hintText: S.of(context).Email,
                          ),
                          SizedBox(height: 15.h),
                          AppTextFormField(

                            labeltext: S.of(context).Password,
                            controller: _passwordController,
                              borderRadius:32,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            hintText: S.of(context).Password,
                              prefexIcon:SvgPicture.asset(
                                'assets/img/Group.svg',
                                fit:  BoxFit.scaleDown,
                              ),
                          ),
                        SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChecked = value!;});
                                    },
                                  ),
                                  const Text('Remember me'),
                                ],
                              ),

                              TextButton(
                                onPressed: () {
                                  context.pushNamed(Routes.forgetPassword);
                                },
                                child: Text(
                                    S.of(context).ForgotPassword,
                                  style: TextStyles.poppins14MediumPurple
                                      .copyWith(color: Color(0xff271D44)),
                                ),
                              ),
                            ],
                          ),
                           SizedBox(height: 20.h),
                          AppTextButton(
                            onPressed: () {
                              // if (formKey.currentState!.validate()) {
                              // }
                           //   context.pushNamed(Routes.navBarScreen);

                                LoginCubit.get(context).loginUser(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                // context.pushNamed(Routes.navigationBar);

                            },
                            backgroundColor: ColorsManager.primaryYellow,
                              borderRadius:32.r,
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: ColorsManager.primaryYellow,
                            //   padding: const EdgeInsets.symmetric(
                            //     vertical: 15,
                            //     horizontal: 80,
                            //   ),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // ), 
                      buttonText: S.of(context).Login, textStyle: TextStyles.inter16BoldDark,
                          
                          ),
                        verticalSpace(24.h),
                          Row(
                            children: [
                              Expanded(child: Divider(color:ColorsManager.lineLightGray)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(S.of(context).Orsigninwith,
                                    style: TextStyles.interSemiBold12GrayMeduim),
                              ),
                              Expanded(child: Divider(color: ColorsManager.lineLightGray)),
                            ],
                          ),
                          verticalSpace(24.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(

                               children: [

                                Container(

                                  height: 52.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular( 32.0),
                                    border: Border.all(
                                      color: ColorsManager.lineLightGray
                                    )
                                  ),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'assets/img/googleicon.png',
                                    ), onPressed: () {  },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 52.h,
                                  width: 165.w,
                                  decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular( 32.0),
                                      border: Border.all(
                                          color: ColorsManager.lineLightGray
                                      )
                                  ),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'assets/img/apple.png',
                                    ), onPressed: () {  },
                                  ),
                                ),


                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    SignInStateUi()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );});
  }
}
