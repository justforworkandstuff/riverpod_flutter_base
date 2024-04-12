import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/core/util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Notification from background will display on system tray by default.
/// Use this method if we need to explicitly do something after receiving notification, e.g. set up Flutter App Badge count
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('fcm: - onBackgroundMessageHandling: ${message.toMap()}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
    'my notification channel', // id
    'my app important channel', // title
    description: 'This channel is used for my app important notifications.', // description
    importance: Importance.max,
    showBadge: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
NotificationHandler? instance;

class NotificationHandler {
  static Future<NotificationHandler?> getInstance() async {
    if (instance == null) {
      instance = NotificationHandler();
      await instance?.init();
    }
    return instance;
  }

  /// Handles messages when app is coming from Terminated state
  /// Two scenario to be catered:
  /// 1: Notifications created by [flutter_local_notifications] package (for Android) > should use [getNotificationAppLaunchDetails()]
  /// 2. Notifications received directly from Firebase push > should use [FCM.getInitialMessage()]
  static Future<void> checkForInitialMessage() async {
    NotificationAppLaunchDetails? appLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    debugPrint('fcm: appLaunchDetails is not null ${appLaunchDetails != null}');
    debugPrint('fcm: appLaunchDetails.didNotificationLaunchApp  ${appLaunchDetails?.didNotificationLaunchApp}');
    debugPrint('fcm: appLaunchDetails.notificationResponse != null ${appLaunchDetails?.notificationResponse != null}');
    if (appLaunchDetails != null &&
        appLaunchDetails.didNotificationLaunchApp &&
        appLaunchDetails.notificationResponse != null) {
      debugPrint('fcm: getInitialMessage from notifications created by flutter_local_notifications');
      onNotificationSelected(appLaunchDetails.notificationResponse);
    } else {
      FirebaseMessaging.instance.getInitialMessage().then((message) {
        debugPrint('fcm: getInitialMessage data: ${message?.toMap()}');
        if (message != null) {
          onNotificationHandled(message);
        }
      });
    }
  }

  Future<void> init() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    const initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationSelected);

    /// Update the iOS foreground notification presentation options to allow heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    /// Handles messages when app is in Foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('fcm: onMessageListened full map ${message.toMap()}');
      debugPrint('fcm: onMessageListened notification ${message.notification?.toMap()}');
      debugPrint('fcm: onMessageListened data ${message.data}');

      /// Android need to manually show the notification when app is on foreground state
      if (Platform.isAndroid) {
        showNotification(message, flutterLocalNotificationsPlugin);
      }
    });

    /// Handles messages when app is opened from Background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('fcm: onMessageOpenedApp full map ${message.toMap()}');
      debugPrint('fcm: onMessageOpenedApp notification ${message.notification?.toMap()}');
      debugPrint('fcm: onMessageOpenedApp data ${message.data}');

      /// iOS: This is triggered when user selects the notification
      onNotificationHandled(message);
    });

    /// Handles actions to be done when notification is received while app is in Background state
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    AuthorizationStatus authorizationStatus;
    final notificationSettings = await FirebaseMessaging.instance.requestPermission();

    authorizationStatus = notificationSettings.authorizationStatus;

    if (authorizationStatus != AuthorizationStatus.denied && authorizationStatus != AuthorizationStatus.notDetermined) {
      String? fcmToken;
      if (kIsWeb) {
        // TODO: Add your own web vapidKey here
        const vapidKey = '';
        fcmToken = await FirebaseMessaging.instance.getToken(vapidKey: vapidKey);
      } else {
        /// FCM getToken() method sometimes return [SERVICE_NOT_AVAILABLE] error
        try {
          final apnsToken = await FirebaseMessaging.instance.getAPNSToken();

          /// For apple platforms, ensure the APNS token is available before making any FCM plugin API calls
          if ((Platform.isIOS && apnsToken != null) || Platform.isAndroid) {
            fcmToken = await FirebaseMessaging.instance.getToken();
          }
          debugPrint('fcm: getToken success: $fcmToken');
          updateTokenToServer(fcmToken);
        } catch (e) {
          debugPrint('fcm: getToken error: ${e.toString()}');
        }
      }
    }
  }

  /// This is triggered when user selects the notification for notifications generated by [flutter_local_notification] package
  static void onNotificationSelected(NotificationResponse? notification) {
    if (notification?.payload?.isNotEmpty == true) {
      final String type = (jsonDecode(notification?.payload ?? '')['notificationType']).toLowerCase();
      final notificationActionType =
          NotificationActionType.values.firstWhereOrNull((element) => element.actionValue == type);
      debugPrint('fcm: onNotificationSelected - type is ${notificationActionType?.actionValue}');
      // TODO: To add your own onNotificationSelected action
    }
  }

  /// This is triggered when user selects the notification for iOS Platform, or user is starting the app from the terminated state
  static void onNotificationHandled(RemoteMessage message) {
    final String type = DynamicParsing(message.data['type']).parseString().toLowerCase();
    final notificationActionType =
        NotificationActionType.values.firstWhereOrNull((element) => element.actionValue == type);
    debugPrint('fcm: onNotificationHandled - type is ${notificationActionType?.actionValue}');
    // TODO: To add your own onNotificationHandled action
  }

  void updateTokenToServer(String? fcmToken) {
    // TODO: Add your own implementation to register this device to server side with the token
    debugPrint('fcm: updateTokenToServer - $fcmToken');
  }

  /// Clears off any existing notifications generated by [flutter_local_notification] package
  Future<void> clearNotificationTray() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future<void> showNotification(
    RemoteMessage message, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  final notificationDetail = Platform.isAndroid
      ? NotificationDetails(
          android: AndroidNotificationDetails(androidChannel.id, androidChannel.name,
              channelDescription: androidChannel.description, icon: 'mipmap/ic_launcher', channelShowBadge: true))
      : const NotificationDetails(iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true));

  if (message.data.isNotEmpty || message.notification != null) {
    try {
      flutterLocalNotificationsPlugin.show(
          message.hashCode,
          message.notification != null ? message.notification?.title : 'My Dumb Dumb App',
          message.notification?.body ?? '',
          notificationDetail,
          payload: message.data.toJson());
    } catch (e) {
      debugPrint('fcm - showNotification error : ${e.toString()}');
    }
  }
}
