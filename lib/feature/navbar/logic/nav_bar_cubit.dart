import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/assets/images.dart';
import '../../blog/logic/blog_cubit.dart';
import '../../blog/ui/screens/blog_screen.dart';
import '../../chat/logic/chat_cubit.dart';
import '../../chat/ui/screen/Chat.dart';
import '../../current_service/logic/current_services_cubit.dart';
import '../../current_service/ui/screens/current_service.dart';
import '../../home/logic/home_cubit.dart';
import '../../home/ui/screen/home_screen.dart';
import '../../profile/logic/profile_cubit.dart';
import '../../profile/ui/screens/profile_screen.dart';




part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());
  static NavBarCubit get(context)=> BlocProvider.of(context);
//bool isSelected=false;
//  getSelectedIndex(int index){
//  if(selectedIndex==index){
//    isSelected=true;
//    emit(ChangeIndexState());
//  }
//}
  final screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: HomeScreen(),
    ),
    BlocProvider(
  create: (context) => BlogCubit(),
  child: BlogScreen(),
),
    BlocProvider(
  create: (context) => ChatCubit(),
  child: ChatScreen(),
),


    BlocProvider(
        create: (context) => ProfileCubit(),
        child: ProfileScreen()
    ),

  ];
  List<String> navIcon =[
    ImagesManager.homeWhite
    ,ImagesManager.blog
    ,ImagesManager.chat
    ,ImagesManager.bag




  ];
  List<String> navIconYellow =[
    ImagesManager.homefill
    ,ImagesManager.blogFill
    ,ImagesManager.chat
    ,ImagesManager.bagFill


  ];
  int selectedIndex=0;
  void changeIndex(int index){
    selectedIndex=index;
    emit(ChangeIndexState());
}}
