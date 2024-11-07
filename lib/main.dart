import 'package:collection_application/app/globalControllers/dataController/data_controller.dart';
import 'package:collection_application/app/views/auth/authScreen/authscreen_view.dart';
import 'package:collection_application/app/views/home/home_screen_view.dart';
import 'package:collection_application/app/data/firestore/firestore_helper.dart';
import 'package:collection_application/custom/topSwipers/threeSwipers/three_swipers_controllers.dart';
import 'package:collection_application/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCyIAVQM8-oa-mS96uzgukoqm56yevsg8o",
          appId: "1:359449937248:android:c4546a21b4f328464fca05",
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
