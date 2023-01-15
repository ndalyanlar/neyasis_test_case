import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:neyasis_test_case/user/domain/models/user_model.dart';
import 'package:neyasis_test_case/user/domain/service/user_service.dart';

@GenerateMocks([UserModel],
    customMocks: [MockSpec<UserModel>(as: #MockUserRelaxed)])
void main() {
  group("User Events", () {
    List<UserModel> users = [];
    test("Fetch Users", () async {
      UserService service = UserService();
      users = await service.fetchUsers(page: 1);

      expect(users, isList);
    });

    test("Get User", () async {
      UserService service = UserService();
      final user = await service.getUser(id: users.first.id);
      expect(user.id, users.first.id);
    });

    test("Update User", () async {
      UserService service = UserService();
      final newUser = users.first.copyWith(name: "${users.first.name} updated");
      final user = await service.updateUser(user: newUser);
      expect(user.name, newUser.name);
      await service.updateUser(user: users.first);
    });

    test("Add user and remove user", () async {
      UserService service = UserService();
      final newUser = users.first.copyWith(name: "new user");
      final user = await service.addUser(user: newUser);
      expect(user, isA<UserModel>());
      await service.removeUser(id: user.id);
    });
  });
}
