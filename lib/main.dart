import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/global.dart';
import 'package:music_app/features/screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDb09qTqpYkfwjk4Cp-2wv0UshYdXspvGI',
      appId: '1:169396261036:android:1b646e262d7bef7cc88f09',
      messagingSenderId: '169396261036',
      projectId: 'music-app-dddb5',
    ),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  systemUi(AppColors.whiteColor);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.appColor),
          scaffoldBackgroundColor: AppColors.whiteColor,
          appBarTheme: AppBarTheme(
            surfaceTintColor: AppColors.transparent,
              backgroundColor: AppColors.appColor,
              foregroundColor: AppColors.whiteColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: AppColors.appColor,
                  systemNavigationBarColor: Colors.transparent,
                  systemNavigationBarDividerColor: Colors.grey.shade200)),
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            constraints: const BoxConstraints(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            hintStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.appColor),
                borderRadius: BorderRadius.circular(2)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.appColor),
                borderRadius: BorderRadius.circular(2)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.appColor),
                borderRadius: BorderRadius.circular(2)),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.appColor),
                borderRadius: BorderRadius.circular(2)),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
