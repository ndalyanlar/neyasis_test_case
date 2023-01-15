import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:neyasis_test_case/generated/locale_keys.g.dart';
import 'package:neyasis_test_case/main.dart' as app;
import 'package:neyasis_test_case/user/widgets/add_user_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text(LocaleKeys.users.tr()), findsOneWidget);

      final Finder addUserButton = find.byType(AddUserButton);

      await tester.tap(addUserButton);

      await tester.pumpAndSettle();
    });
  });
}
