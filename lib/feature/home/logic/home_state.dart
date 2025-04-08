part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<RequestModel> requests;
  HomeLoaded({required this.requests});
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
class RequestStatusUpdating extends HomeState {}

class RequestStatusUpdated extends HomeState {
  final String requestId;
  final String newStatus;

  RequestStatusUpdated({required this.requestId, required this.newStatus});
}

class RequestStatusError extends HomeState {
  final String message;
  RequestStatusError({required this.message});
}