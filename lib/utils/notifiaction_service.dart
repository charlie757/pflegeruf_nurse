import 'dart:ui';
// import 'package:cn_delivery/utils/session_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nurse/providers/dashboard_provider/notification_provider.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/utils.dart';
import 'package:provider/provider.dart';

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
      if (SessionManager.token.isNotEmpty) {
        Provider.of<NotificationProvider>(navigatorKey.currentContext!,
                listen: false)
            .unreadNotificationApiFunction();
      }
      print("data...${message.messageType}");
      print("data...${message.data}");
      print("data...${message.notification!.body}");

      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      AppleNotification? appleNotification = message.notification?.apple;
      if (androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification!.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    color: const Color.fromRGBO(71, 79, 156, 1),
                    playSound: true,
                    enableLights: true,
                    icon: '@mipmap/ic_launcher_notification',
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
    await getToken();
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher_notification');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      print("gdfgdg...${notificationResponse.payload}");
      // if (SessionManager.token.isNotEmpty) {
      //   Provider.of<NotificationProvider>(navigatorKey.currentContext!,
      //           listen: false)
      //       .getNotificationApiFunction(false);
      // }
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("gdfgdgacvssdvbdfkb...${message.notification!.title}");
      // if (SessionManager.token.isNotEmpty) {
      //   Provider.of<NotificationProvider>(navigatorKey.currentContext!,
      //           listen: false)
      //       .getNotificationApiFunction(false);
      // }
    });
  }

  Future<String?> getToken() async {
    String? token = await fcm.getToken();
    print('Token: $token');
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.getAPNSToken();
    FirebaseMessaging.instance.getToken().then((token) async {
      print('fcm-token-----$token');
      SessionManager.setFcmToken = token!;
    });
    return token;
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }
}
