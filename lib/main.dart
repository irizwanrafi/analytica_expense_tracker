import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'utilities/decorators.dart';
import 'utilities/functions.dart';
import 'view/home/screen.dart';
import 'view/intro/intro_screen.dart';

String _initialRoute = '/login';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'J5ArPTPzi5PY83s6I690D2UxYZh4tYaN0I8rppX1';
  const keyClientKey = 'v4he4Dmds4YYozkE3VM8pSA5EquKkjqUy48RNFBx';
  const keyParseServerUrl = 'https://parseapi.back4app.com/';
  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
  );

  ParseUser? currentUser = await ParseUser.currentUser();
  if (currentUser != null) _initialRoute = '/home';

  setPlatformMinSizes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: MyColors.c7)),
      scrollBehavior: _MyCustomScrollBehavior(),
      initialRoute: _initialRoute,
      getPages: [
        GetPage(name: '/login', page: () => const MyIntroScreen()),
        GetPage(name: '/home', page: () => const MyHomeScreen()),
      ],
    );
  }
}

class _MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}
