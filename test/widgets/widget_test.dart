// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:neyasis_test_case/core/localization.dart';
import 'package:neyasis_test_case/generated/locale_keys.g.dart';
import 'package:neyasis_test_case/main.dart';
import 'package:neyasis_test_case/user/domain/models/user_model.dart';
import 'package:neyasis_test_case/user/domain/service/user_service.dart';
import 'package:neyasis_test_case/user/providers/cubit/user_events_cubit.dart';
import 'package:neyasis_test_case/user/screens/index.dart';
import 'package:neyasis_test_case/user/widgets/add_user_button.dart';
import 'package:neyasis_test_case/user/widgets/preloader_listview.dart';

import 'package:neyasis_test_case/user/widgets/user_card.dart';
import 'package:neyasis_test_case/user/widgets/user_list_view.dart';

@GenerateMocks([
  UserModel
], customMocks: [
  MockSpec<UserModel>(
    as: #MockUserRelaxed,
    onMissingStub: OnMissingStub.returnDefault,
  )
])
void main() async {
  late UserModel user;

  group("Widgets Test", () {
    setUp(() {
      user = UserModel(
          name: "name",
          surname: "surname",
          identity: "identity",
          phoneNumber: "phoneNumber",
          id: "id",
          salary: 12000,
          birthDate: DateTime.now());
    });
    testWidgets('User Card View Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: UserCard(
            editPressed: () {
              user = user.copyWith(id: "changed_id");
            },
            removePressed: () {
              user = user.copyWith(id: "removed_id");
            },
            user: user,
          ),
        ),
      ));
      final findEditPressed =
          find.widgetWithText(ElevatedButton, LocaleKeys.edit.tr());
      final findRemovePressed =
          find.widgetWithText(OutlinedButton, LocaleKeys.delete.tr());
      await tester.tap(findEditPressed);
      expect(user.id, "changed_id");
      await tester.tap(findRemovePressed);
      expect(user.id, "removed_id");
    });

    testWidgets('UserApp MyHomePage Exist Test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          EasyLocalization(
            path: MyLocalization.path,
            startLocale: MyLocalization.tr,
            supportedLocales: MyLocalization.localList,
            child: Builder(builder: (context) {
              return const UserApp();
            }),
          ),
        );
        await tester.pump();

        final findMyHomePageWidget = find.byType(MyHomePage);

        expect(findMyHomePageWidget, findsWidgets);
      });
    });
  });
}
