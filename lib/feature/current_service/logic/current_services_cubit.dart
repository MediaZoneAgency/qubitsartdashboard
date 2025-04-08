import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'current_services_state.dart';

class CurrentServicesCubit extends Cubit<CurrentServicesState> {
  CurrentServicesCubit() : super(CurrentServicesInitial());
  static CurrentServicesCubit get(context)=> BlocProvider.of(context);
  List<String> currentServicesState = ['All','InReview','InProgress','Done'];
  int selectedIndex=0;
  void changeIndex(int index){
    selectedIndex=index;
    emit(ChangeIndexState());
  }
}
