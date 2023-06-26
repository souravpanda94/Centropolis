import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'Centropolis_123', // id
  'Centropolis', // title
  importance: Importance.max,
);

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();
  final fcmTokenCtlr = StreamController<String>.broadcast();

  setNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        streamCtlr.sink.add(jsonEncode(message.data));
        // if (message.containsKey('notification')) {
        // Handle notification message
        // streamCtlr.sink.add(message.notification);
        // }
        // Or do other work.

        if (message.notification != null) {
          titleCtlr.sink.add(message.notification!.title!);
          bodyCtlr.sink.add(message.notification!.body!);
        }

        // bodyCtlr.stream.listen((event) {
        //
        // });

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        // if (kDebugMode) {
        //   print("notification received :::: $notification");
        // }

        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);

        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  playSound: true,
                  priority: Priority.high,
                  importance: Importance.max,
                  // other properties...
                ),
              ));
          // flutterLocalNotificationsPlugin.show(
          //   notification.hashCode,
          //   notification.title,
          //   notification.body,
          //   const NotificationDetails(
          //     android: AndroidNotificationDetails(
          //         'full screen channel id', 'full screen channel name',
          //         priority: Priority.high,
          //         importance: Importance.max,
          //         fullScreenIntent: true,
          //         playSound: true,
          //         visibility: NotificationVisibility.public
          //         // other properties...
          //         ),
          //   ),
          // );
        }
      },
    );
    // With this token you can test it easily on your phone
    _firebaseMessaging.getToken().then((value) {
      fcmTokenCtlr.sink.add(value!);
      if (kDebugMode) {
        print('FCM Token: $value');
      }
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    if (kDebugMode) {
      print("notification data received :::: ${message.data}");
    }
    final streamCtlr = StreamController<String>.broadcast();

    streamCtlr.sink.add(jsonEncode(message.data));

    if (message.data.containsKey('notification')) {
      // Handle notification message
      final notification = message.data['notification'];
    }
    // Or do other work.
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
    fcmTokenCtlr.close();
  }
}
