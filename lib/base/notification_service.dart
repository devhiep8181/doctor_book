import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late final NotificationDetails notificationDetails;

  NotificationService._internal() {
    // Khởi tạo NotificationDetails
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
    );
    notificationDetails = const NotificationDetails(android: androidDetails);
  }

  Future<void> init() async {
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        // Handle notification responses here.
      },
    );
  }

  Future<void> showNotification(
    int id,
    String? title,
    String? body,
  ) async {
    await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }
}
