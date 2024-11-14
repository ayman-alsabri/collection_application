import 'package:collection_application/app/data/messaging/firebase_messaging_controller.dart';
import 'package:collection_application/app/data/messaging/notification_helper.dart';
import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:collection_application/app/views/auth/authScreen/authscreen_view.dart';
import 'package:collection_application/app/views/home/home_screen_view.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper().setupNotification();
  await initFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FirebaseMessagingController());
    Get.put(DataController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تجميع البيانات',
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
