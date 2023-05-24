import 'dart:async';
import 'dart:io';
import 'package:centropolis/providers/company_provider.dart';
import 'package:centropolis/providers/conference_history_provider.dart';
import 'package:centropolis/providers/executive_lounge_history_provider.dart';
import 'package:centropolis/providers/gx_fitness_reservation_provider.dart';
import 'package:centropolis/providers/user_provider.dart';
import 'package:centropolis/providers/visit_reservation_list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/complaints_received_detail_provider.dart';
import 'providers/conference_history_details_provider.dart';
import 'providers/incovenience_list_provider.dart';
import 'providers/lightout_list_provider.dart';
import 'providers/sleeping_room_detail_history_provider.dart';
import 'providers/sleeping_room_history_provider.dart';
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
          ChangeNotifierProvider(create: (_) => GxFitnessReservationProvider()),
          ChangeNotifierProvider(
              create: (_) => ExecutiveLoungeHistoryProvider()),
          ChangeNotifierProvider(create: (_) => ConferenceHistoryProvider()),
          ChangeNotifierProvider(
              create: (_) => ConferenceHistoryDetailsProvider()),
          ChangeNotifierProvider(create: (_) => InconvenienceListProvider()),
          ChangeNotifierProvider(create: (_) => SleepingRoomHistoryProvider()),
          ChangeNotifierProvider(
              create: (_) => SleepingRoomHistoryDetailsProvider()),
          ChangeNotifierProvider(create: (_) => LightoutListProvider()),
          ChangeNotifierProvider(create: (_) => ComplaintsReceivedDetailsProvider()),
          ChangeNotifierProvider(create: (_) => VisitReservationListProvider()),
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
