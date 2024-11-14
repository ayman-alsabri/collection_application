import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  factory NotificationHelper() => _instance;
  static final _instance = NotificationHelper._intrnal();
  NotificationHelper._intrnal();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'collection_application', // id
    'High Importance Notifications', // title
    importance: Importance.max, playSound: true, enableVibration: true,
    showBadge: true,
  );
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const InitializationSettings _initializationSettings =
      InitializationSettings(
          android: AndroidInitializationSettings('noti_icon'));

  Future<void> setupNotification() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) {
    return FlutterLocalNotificationsPlugin().show(
        id,
        title,
        body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        )));
  }
}
