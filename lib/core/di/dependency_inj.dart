
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import '../../feature/home/logic/home_cubit.dart';
import '../../feature/navbar/logic/nav_bar_cubit.dart';
import '../../feature/profile/logic/profile_cubit.dart';
import '../../feature/sign_in/data/repo/login_repo.dart';
import '../../feature/sign_in/logic/login_cubit.dart';
import '../network/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async
{
 Dio dio = DioFactory.getDio();
 getIt.registerLazySingleton<NavBarCubit>(() => NavBarCubit());

 getIt.registerLazySingleton<HomeCubit>(() => HomeCubit());
 getIt.registerLazySingleton<LoginRepoImpl>(() => LoginRepoImpl());
 getIt.registerFactory<LoginCubit>(() => LoginCubit());
 getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
}