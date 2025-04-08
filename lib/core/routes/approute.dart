
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubitarts/core/routes/routes.dart';

import '../../feature/forget_password/logic/forget_password_cubit.dart';
import '../../feature/forget_password/ui/screens/forget_password.dart';
import '../../feature/navbar/logic/nav_bar_cubit.dart';
import '../../feature/navbar/ui/screens/nav_bar_screen.dart';
import '../../feature/sign_in/logic/login_cubit.dart';
import '../../feature/sign_in/ui/screens/sign_in_screen.dart';
import '../../feature/splash/view/splash.dart';
import '../di/dependency_inj.dart';
import '../loclization/localization_cubit.dart';


class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    //final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
         return MaterialPageRoute(
         builder: (_) => const SplashScreen(),
        );


      //
      case Routes.loginScreen:
     return MaterialPageRoute(
         builder: (_) =>
             BlocProvider(
              create: (context) => getIt<LoginCubit>(),
             child: SignInScreen(),
           ),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgetPasswordCubit(),
            child: ForgetPasswordScreen(),
          ),
        );
    //   case Routes.homeScreen:
    //     return MaterialPageRoute(
    //
    // builder: (_) =>MultiBlocProvider(
    //     providers: [
    //       BlocProvider<HomeCubit>.value(
    //         value: getIt<HomeCubit>(),
    //       ),
    //       BlocProvider<ProductCubit>.value(
    //         value: getIt<ProductCubit>(),
    //       ),
    //       BlocProvider<CartCubit>.value(
    //         value: getIt<CartCubit>(),
    //       ),
    //     ], child: const HomeScreen()),
    //      );
    //   case Routes.categoriesScreen:
    //     return MaterialPageRoute(
    //         builder: (_)=>
    //             BlocProvider(
    //               create: (context) => getIt<HomeCubit>(),
    //               child:CategoriesScreen(),
    //             ),
    //     );
      // case Routes.girdviewScreen:
      //   return MaterialPageRoute(
      //     builder: (_)=>
      //         BlocProvider(
      //           create: (context) => getIt<ProductCubit>(),
      //           child: CoursesGirdview(),
      //         ),
      //   );

        // case Routes.girdviewScreen
        // return MaterialPageRoute(
        //     builder:(_)=>
        //         BlocProvider.value(value:
        //         getIt<ProductCubit>,
        //         child: CoursesGirdviewScreen(),)
        // );
      case Routes.navBarScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value:getIt<NavBarCubit>(),
            child: NavBarScreen(),
          ),
        );
      //  case Routes.loginScreen:
      //    return MaterialPageRoute(
      //     builder: (_) =>
      //          BlocProvider(
      //            create: (context) => getIt<SignInCubit>(),
      //           child: SignInScreen(),
      //          ),
      //    );
      // case Routes.cartScreen:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         BlocProvider(
      //           create: (context) => getIt<CartCubit>(),
      //           child: CartScreen(),
      //         ),
      //   );
    //   case Routes.checkoutScreen:
    //     return MaterialPageRoute(
    //       builder: (_) =>
    //           BlocProvider(
    //             create: (context) => getIt<ProductCubit>(),
    //             child: CheckoutScreen(),
    //           ),
    //     );
    //
    //   case Routes.wishListScreen:
    //     return MaterialPageRoute(
    //
    //       builder: (_) =>MultiBlocProvider(
    //           providers: [
    //
    //             BlocProvider<ProfileCubit>.value(
    //               value: getIt<ProfileCubit>(),
    //             ),
    //             BlocProvider<FavCubit>.value(
    //               value: getIt<FavCubit>(),
    //             ),
    //           ], child: const WishListScreen()),
    //     );
    //   case Routes.accountInfoScreen:
    //     return MaterialPageRoute(
    //       builder: (_) =>
    //          BlocProvider.value(
    //             value: getIt<ProfileCubit>(),
    //             child: AccountInfoScreen(),
    //           ),
    //     );
    //   case Routes.coursesGridViewScreen:
    //     return MaterialPageRoute(
    //       builder: (_) =>MultiBlocProvider(providers: [
    //         BlocProvider.value(
    //              value: getIt<ProductCubit>()
    //         ),
    //         BlocProvider.value(
    //             value: getIt<FavCubit>()
    //         ),
    //         BlocProvider<ProfileCubit>.value(
    //           value: getIt<ProfileCubit>(),
    //         ),
    //       ],
    //           child:CoursesGirdviewScreen())
    //
    //     );
    //   case Routes.editAccountInfoScreen:
    //     return MaterialPageRoute(
    //       builder: (_) =>
    //           BlocProvider.value(
    //             value: getIt<ProfileCubit>(),
    //             child: EditAccountInfoScreen(),
    //           ),
    //     );
    //   case Routes.OTPScreen:
    //     return MaterialPageRoute(
    //       builder: (_) =>
    //           BlocProvider(
    //             create: (context) => getIt<SignInCubit>(),
    //             child: VerifyCode(),
    //           ),
    //     );
    //
    //   case Routes.forgetPasswordScreen:
    //     return MaterialPageRoute(
    //       builder: (_) =>
    //           BlocProvider(
    //             create: (context) => getIt<SignInCubit>(),
    //             child: ForgetPasswordScreen(),
    //           ),
    //     );
    //   case Routes.resetPasswordScreen:
    //     return MaterialPageRoute(
    //       builder: (_) =>
    //           BlocProvider(
    //             create: (context) => getIt<SignInCubit>(),
    //             child: ResetPasswordScreen(),
    //           ),
    //     );
    //
    //    case Routes.fieldScreen:
    //      return MaterialPageRoute(
    //      builder: (_) =>  FieldsScreen(),
    //    );
    //   case Routes.typeFieldsScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => TypeFieldsScreen(type: '',),
    //     );
    //   //
    //
    //   case Routes.DetailsScreen:
    //     return MaterialPageRoute(
    //
    //       builder: (_) =>MultiBlocProvider(
    //           providers: [
    //
    //             BlocProvider<ProfileCubit>.value(
    //               value: getIt<ProfileCubit>(),
    //             ),
    //             BlocProvider<FavCubit>.value(
    //               value: getIt<FavCubit>(),
    //             ),
    // BlocProvider(
    // create: (context) => getIt<ProductCubit>()),
    //           ], child:  DetailsScreen( settings.arguments as ProductModel),
    //       ),
    //     );
      // case Routes.DetailsScreen:
      //    return MaterialPageRoute(
      //     builder: (_) =>
      //         BlocProvider(
      //           create: (context) => getIt<ProductCubit>(),
      //           child: DetailsScreen( settings.arguments as ProductModel),
      //         ),
      //   );
      // case Routes.girdviewScreen:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         BlocProvider(
      //           create: (context) => getIt<ProductCubit>(),
      //           child: CoursesGirdview( settings.arguments as String),
      //         ),
      //   );
      // case Routes.girdviewScreen:
      //   return MaterialPageRoute(
      //     builder: (_)=> MultiBlocProvider(
      //       providers: [
      //     BlocProvider.value(
      //     value:  getIt<ProductCubit>()),
      //         BlocProvider<FavCubit>.value(
      //           value: getIt<FavCubit>(),
      //         ),
      //         BlocProvider<ProfileCubit>.value(
      //           value: getIt<ProfileCubit>(),
      //         ),
      //       ],
      //       child:CoursesGirdview( settings.arguments as String ?? 'DefaultArgument'),
      //     ),
      //
      //   );
      // case Routes.profileScreen:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         BlocProvider<ProfileCubit>.value(
      //           value: getIt<ProfileCubit>(),
      //           child: ProfileScreen(),
      //         )
      //   );
      //
      // case Routes.settingsScreen:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //        BlocProvider.value(
      //           value: getIt<ProfileCubit>(),
      //           child:const SettingScreen() ,
      //         ),
      //   );
      // case Routes.deleteAccountScreen:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //        BlocProvider.value(
      //           value: getIt<ProfileCubit>(),
      //           child: DeleteAccountScreen(),
      //         ),
      //   );
      //
      // case Routes.searchScreen:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         BlocProvider.value(
      //           value: getIt<SearchCubit>(),
      //           child: SearchScreen(),
      //         ),
      //   );
      //
      // case Routes.resultScreen:
      //   return MaterialPageRoute(
      //     builder: (_) =>
      //         BlocProvider.value(
      //           value:  getIt<SearchCubit>(),
      //           child: SearchResultScreen(),
      //         ),
      //   );

    return null;
    }
    return null;
  }
}