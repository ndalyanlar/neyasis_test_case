import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/network_manager.dart';
import '../models/user_model.dart';
import '../repository/user_repository.dart';

class UserService implements UserRepository {
  @override
  Future<UserModel> addUser({required UserModel user}) async {
    final response = await NetworkManager.instance.dio.post(
      "/users",
      data: user.toJson(),
    );

    switch (response.statusCode) {
      case HttpStatus.created:
        return UserModel.fromJson(response.data);
      default:
        throw MyCustomException(response.statusCode!, response.statusMessage!);
    }
  }

  @override
  Future<List<UserModel>> fetchUsers({required int page}) async {
    final response = await NetworkManager.instance.dio.get(
      "/users",
      queryParameters: {"limit": 10, "page": page},
    );

    switch (response.statusCode) {
      case HttpStatus.ok:
        return (response.data as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
      default:
        throw MyCustomException(response.statusCode!, response.statusMessage!);
    }
  }

  @override
  Future<UserModel> getUser({required String id}) async {
    try {
      final response = await NetworkManager.instance.dio.get("/users/$id");
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      throw MyCustomException(e.response!.statusCode!, e.message);
    }
  }

  @override
  Future<UserModel> removeUser({required String id}) async {
    final response = await NetworkManager.instance.dio.delete("/users/$id");

    switch (response.statusCode) {
      case HttpStatus.ok:
        return UserModel.fromJson(response.data);
      default:
        throw MyCustomException(response.statusCode!, response.statusMessage!);
    }
  }

  @override
  Future<UserModel> updateUser({required UserModel user}) async {
    final response = await NetworkManager.instance.dio.put(
      "/users/${user.id}",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: user.toJson(),
    );

    switch (response.statusCode) {
      case HttpStatus.ok:
        return UserModel.fromJson(response.data);
      default:
        throw MyCustomException(response.statusCode!, response.statusMessage!);
    }
  }
}

class MyCustomException implements Exception {
  String message;
  int errorCode;
  MyCustomException(this.errorCode, this.message);
}
