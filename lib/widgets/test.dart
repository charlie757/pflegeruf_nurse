import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print("paylod,,,,,${notificationResponse.payload}");
  // handle action
}

class NotificationService {
  FirebaseMessaging fcm = FirebaseMessaging.instance;
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', //id
      'High Importance Notifications', // name
      showBadge: true,
      importance: Importance.high,
      playSound: true,
      enableLights: true,
      enableVibration: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    configLocalNotification();
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  Future initialize() async {
    FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    configLocalNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("data...${message.messageType}");
      print("data...${message.data}");
      print("data...${message.category}");

      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      AppleNotification? appleNotification = message.notification?.apple;
      if (androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            payload: notification!.title,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    color: const Color.fromRGBO(71, 79, 156, 1),
                    playSound: true,
                    // actions: [
                    //  const AndroidNotificationAction(
                    //      'id', 'Okay',titleColor: Color(0xff000000),cancelNotification: true,showsUserInterface: true)
                    // ],
                    // fullScreenIntent: true,
                    enableLights: true,
                    icon: '@mipmap/ic_launcher',
                    styleInformation: const BigTextStyleInformation(''),
                    channelAction:
                        AndroidNotificationChannelAction.createIfNotExists)));
        // Get.toNamed(AppRoutes.notification);
      }
      if (appleNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            payload: notification.title,
            const NotificationDetails(
                iOS: DarwinNotificationDetails(
                    presentAlert: true, presentSound: true, presentBadge: true)
                // iOS: DarwinInitializationSettings(presentSound: true,
                //   presentAlert: true,
                //   presentBadge: true,
                // )

                ));
      }
    });
    // await getToken();
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      print("sdfsdsf...${notificationResponse.payload}");
      // if (Utils.extractBeforeColon(
      //         notificationResponse.payload.toString().toLowerCase()) ==
      //     'location') {
      //   viloationsFunction();
      // } else if (Utils.extractBeforeColon(
      //         notificationResponse.payload.toString().toLowerCase()) ==
      //     'tampering') {
      //   deviceTamperingFunction();
      // } else if (Utils.extractBeforeColon(
      //         notificationResponse.payload.toString().toLowerCase()) ==
      //     'stealth') {
      //   stealthModeFunction();
      // } else if (Utils.extractBeforeColon(
      //         notificationResponse.payload.toString().toLowerCase()) ==
      //     'milestone') {
      //   milestonesFunction();
      // }
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.notification!.title);
      // if (Utils.extractBeforeColon(
      //         message.notification!.title.toString().toLowerCase()) ==
      //     'location') {
      //   viloationsFunction();
      // } else if (Utils.extractBeforeColon(
      //         message.notification!.title.toString().toLowerCase()) ==
      //     'tampering') {
      //   deviceTamperingFunction();
      // } else if (Utils.extractBeforeColon(
      //         message.notification!.title.toString().toLowerCase()) ==
      //     'stealth') {
      //   stealthModeFunction();
      // } else if (Utils.extractBeforeColon(
      //         message.notification!.title.toString().toLowerCase()) ==
      //     'milestone') {
      //   milestonesFunction();
      // }
      // handleNotificationTapFromMessage(message, context);
    });
  }
}
