import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Routes/AppRoutes.dart';
import 'Resources/Theme.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme(context),
      routerDelegate: AppRoutes.router.routerDelegate,
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
    );
  }
}