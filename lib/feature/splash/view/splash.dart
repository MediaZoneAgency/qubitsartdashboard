import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubitarts/core/helpers/extensions.dart';

import '../../../core/db/cash_helper.dart';
import '../../../core/routes/routes.dart';


import '../../../core/sharedWidgets/background_widget.dart';

import '../../../core/theming/styles.dart';
import '../../../generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     tohome();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                const Background(backgroundImage: "assets/img/background.png",),
                Center(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Image.asset(
                 "assets/img/qubitarts 2.png",
                    height: 53.h,
                    width: 53.w,
                  ),
                    AnimatedTextKit(animatedTexts:
                    [TyperAnimatedText("Ubitarts",textStyle: TextStyles.plusJakartaSans48ExtraBoldWhite,)]),
                ],),)
              ],
            )),
      ),
    );
  }

  void tohome() {
    Future.delayed(Duration(seconds: 3), () async {
      context.pushNamed(Routes.loginScreen);
      //    WidgetsFlutterBinding.ensureInitialized();
          String? token = await CashHelper.getStringScoured(key: Keys.token);
          print(token);
         // token==null? context.pushReplacementNamed(Routes.welcome):context.pushReplacementNamed(Routes.navigationBar);
  //     //    //context.pushReplacementNamed(Routes.welcome);
  //     //    //  DioFactory.setTokenIntoHeaderAfterLogin(response.token!);
  //     //  if(  token == null){
  //     //    context.pushReplacementNamed(Routes.welcome);
  //     //  }else{
  //     //    if(await SplashCubit.get(context).checkToken(token)){
  //     //      DioFactory.setTokenIntoHeaderAfterLogin(token);
  //     //      context.pushReplacementNamed(Routes.navigationBar);
  //     //    }else{
  //     //      await CashHelper.clear();
  //     //      context.pushReplacementNamed(Routes.welcome);
  //     //    }
  //     //      //   .then((value) {
  //     //      // if (value) {
  //     //      //   context.pushReplacementNamed(Routes.welcome);
  //     //      // }
  //     //   // });
    });
  }
}


