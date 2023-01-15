import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'core/localization.dart';
import 'user/screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: MyLocalization.path,
      //* Change for english language
      startLocale: MyLocalization.tr,
      supportedLocales: MyLocalization.localList,
      child: const UserApp(),
    ),
  );
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: EasyLocalization.of(context)!.delegates,
      title: 'Neyasis Test Case',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}
