import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:collection_application/app/views/auth/authScreen/authscreen_view.dart';
import 'package:collection_application/app/views/home/home_screen_view.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  final apiKey = dotenv.env['API_KEY'];
  final appId = dotenv.env['APP_ID'];
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: apiKey!,
          appId: appId!,
          messagingSenderId: "359449937248",
          projectId: "data-collection-97956"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DataController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word App',
      theme: AppTheme.appTheme,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
            snapshot.hasData ? const HomeScreenView() : const AuthscreenView(),
      ),
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
