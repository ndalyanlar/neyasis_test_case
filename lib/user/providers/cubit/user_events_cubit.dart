import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/user_model.dart';
import '../../domain/service/user_service.dart';
import '../../enum/user_events_enum.dart';

part 'user_events_state.dart';

class UserEventsCubit extends Cubit<UsersState> {
  UserEventsCubit(this.service) : super(UserListInitial());

  UserService service;
  List<UserModel> users = [];
  int page = 1;

  bool isLastPage = false;

  Future<void> loadMoreUsers() async {
    try {
      page++;
      emit(PaginationLoading());
      final newUsers = await service.fetchUsers(page: page);
      if (newUsers.isNotEmpty) {
        users.addAll(newUsers);
      } else {
        isLastPage = true;
      }
      emit(UserListLoaded(users: users));
    } on DioError catch (e) {
      emit(UserEventsError(e.response!.statusMessage!));
    }
  }

  Future<void> fetchUsers() async {
    try {
      emit(UserListLoading());
      users = await service.fetchUsers(page: page);
      emit(UserListLoaded(
        users: users,
      ));
    } on MyCustomException catch (e) {
      emit(UserEventsError(e.message));
    }
  }

  Future<void> editUser({required UserModel userModel}) async {
    try {
      emit(UserLoading());
      final user = await service.updateUser(user: userModel);
      emit(UserSuccessEvents(userModel: user, type: UserEventType.edited));
    } on DioError catch (e) {
      emit(UserEventsError(e.message));
    }
  }

  Future<void> addUser({required UserModel userModel}) async {
    try {
      emit(UserLoading());
      final user = await service.addUser(user: userModel);
      emit(UserSuccessEvents(userModel: user, type: UserEventType.added));
      // emit(UserSuccessEvents());

    } on DioError catch (e) {
      emit(UserEventsError(e.message));
    }
  }

  Future removeUser({required UserModel userModel}) async {
    try {
      final user = await service.removeUser(id: userModel.id);
      emit(UserSuccessEvents(userModel: user, type: UserEventType.removed));
      return user;
    } on DioError catch (e) {
      emit(UserEventsError(e.message));
    }
  }
}
