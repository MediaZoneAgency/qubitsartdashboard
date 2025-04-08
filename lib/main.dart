

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import    'package:sizer/sizer.dart';
import 'core/di/dependency_inj.dart';
import 'core/db/cash_helper.dart';
import 'core/loclization/localization_cubit.dart';
import 'core/routes/approute.dart';
import 'core/routes/routes.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

import 'generated/l10n.dart'; // Import the AuthRepository

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await setupGetIt();
  runApp(EducationApp(
    appRouter: AppRouter(),
  ));
}

class EducationApp extends StatelessWidget {
  final AppRouter appRouter;

  const EducationApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => LocalizationCubit()),



        // BlocProvider<NavBarCubit>.value(
        //   value: getIt<NavBarCubit>(),
        // ),


      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, localizationState) {
            // Determine the current locale
            Locale currentLocale;
            if (localizationState is LocalizationChanged) {
              currentLocale = localizationState.locale;
            } else {
              // Provide a default locale if no selection has been made
              currentLocale = ui.window.locale; // Default to English
            }

            return MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              locale: currentLocale,
              theme: ThemeData(),
              title: 'QubitArts',
              debugShowCheckedModeBanner: false,
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              initialRoute: Routes.splashScreen,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
