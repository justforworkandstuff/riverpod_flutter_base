import 'dart:io';

import 'package:dumbdumb_flutter_app/app/assets/app_options.dart';
import 'package:dumbdumb_flutter_app/app/assets/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

typedef NotificationClickedCallback = void Function(String payload);
typedef NotificationPageRedirectCallback = void Function(String shouldRedirect);
typedef NotificationReceivedCallback = void Function();

/// Notification from background will display on system tray by default.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'my_dumbdumb_channel', // id
  'my app important channel', // title
  description: 'This channel is used for my app important notifications.', // description
  importance: Importance.high,
  showBadge: true
);

NotificationHandler? instance;

class NotificationHandler {

  static Future<NotificationHandler?> getInstance(EnvironmentType type) async {
    if (instance == null) {
      instance = NotificationHandler();
      await instance?.init(type);
    }
    return instance;
  }

  Future<void> init(EnvironmentType type) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform(type));

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: selectNotification);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('firebase onMessage: ${message.notification?.title}');
      showNotification(message, flutterLocalNotificationsPlugin);
    });

    final _token = await FirebaseMessaging.instance.getToken();

    updateTokenToServer(_token);
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var notificationDetail = Platform.isAndroid
        ? NotificationDetails(
            android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'mipmap/ic_launcher',
              channelShowBadge: true
          ))
        : NotificationDetails(
            iOS: DarwinNotificationDetails(
                presentAlert: true, presentBadge: true));

    try {
      flutterLocalNotificationsPlugin.show(message.hashCode,
          message.notification?.title ?? "My Dumb Dumb App",
          message.notification?.body ?? "-",
          notificationDetail);
    } catch (e) {
      print(e.toString());
    }
  }

  Future selectNotification(NotificationResponse? payload) async {

  }

  void updateTokenToServer(String? token) {

  }
}
