import '../models/user_model.dart';

abstract class UserRepository<T> {
  Future<T> fetchUsers({required int page});
  Future<T> getUser({required String id});
  Future<T> updateUser({required UserModel user});
  Future<T> removeUser({required String id});
  Future<T> addUser({required UserModel user});
}
