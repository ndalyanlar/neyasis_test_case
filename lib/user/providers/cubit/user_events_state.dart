part of 'user_events_cubit.dart';

abstract class UsersState {}

class UserListInitial extends UsersState {
  UserListInitial();
}

class UserListLoading extends UsersState {
  UserListLoading();
}

class UserListLoaded extends UsersState {
  List<UserModel> users;
  // bool isLastPage;
  UserListLoaded({required this.users});
}

class UserEventsError extends UsersState {
  String message;
  UserEventsError(this.message);
}

class UserLoading extends UsersState {
  UserLoading();
}

class UserSuccessEvents extends UsersState {
  final UserModel userModel;
  final UserEventType type;
  UserSuccessEvents({required this.type, required this.userModel});
}

class PaginationLoading extends UsersState {
  PaginationLoading();
}
