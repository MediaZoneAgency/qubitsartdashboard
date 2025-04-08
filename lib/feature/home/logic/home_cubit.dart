import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:qubitarts/feature/home/data/model/services_Card_model.dart';

import '../data/model/request_model.dart';
import '../data/request_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<RequestModel> requests = [];
  List<RequestModel>  requestsbystatus=[];
  RequestRepository requestRepository = RequestRepository();

  void fetchRequests() async {
    emit(HomeLoading());
    try {
      requests = await requestRepository.getRequests();

      // Log the fetched requests
      for (var request in requests) {
        print("Request ID: ${request.id}, Data: ${request.toMap()}");
      }

      emit(HomeLoaded(requests: requests));
    } catch (e) {
      print("Error fetching requests: $e");
      emit(HomeError(message: e.toString()));
    }
  }


  void fetchRequestsByStatus(String status) async {
    emit(HomeLoading());
    try {
      requestsbystatus = await requestRepository.getRequestsByStatus(status);
      emit(HomeLoaded(requests: requests));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> updateRequestStatus(String requestId, String newStatus) async {
    emit(RequestStatusUpdating());
    try {
      await requestRepository.updateRequestStatus(requestId, newStatus);
      emit(RequestStatusUpdated(requestId: requestId, newStatus: newStatus));
      fetchRequests(); // تحديث القائمة بعد التعديل
    } catch (e) {
      emit(RequestStatusError(message: e.toString()));
    }
  }
}
