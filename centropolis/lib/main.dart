import 'dart:async';
import 'dart:io';
import 'package:centropolis/providers/company_provider.dart';
import 'package:centropolis/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/common_module/splash.dart';
import 'package:easy_localization/easy_localization.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      /* set Status bar color in Android devices. */
      statusBarIconBrightness: Brightness.dark,
      /* set Status bar icons color in Android devices.*/
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en-US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => CompanyProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(brightness: Brightness.light, fontFamily: "Regular"),
      home: const SplashScreen(),
    );
  }
}
