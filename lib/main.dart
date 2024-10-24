import 'package:collection_application/app/auth/authScreen/authscreen_view.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word App',
        theme:AppTheme.appTheme,
        home: const AuthscreenView(),
        locale: const Locale('ar', 'SA'),
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
      );
  }
}