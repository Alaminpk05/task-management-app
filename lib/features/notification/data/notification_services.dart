import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_management_app/features/bottom_nav_bar/presentation/page/bottom_nav.dart';
import 'package:task_management_app/main.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static String?
      pendingPayload; // Temporary storage for payload when app is not ready

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    // Handle notification that launched the app
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      final String? payload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
      if (payload != null) {
        pendingPayload = payload; // Store payload temporarily
      }
    }

    // Request permission for notifications (Android)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    // Request permission for notifications (iOS)
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  } //END OF INITIALIZATION

  /// Handle notification click
  static Future<void> _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final payload = notificationResponse.payload;

    if (payload != null) {
      _handleNotificationPayload(payload);
    }
  }

  /// Handle notification payload
  static void _handleNotificationPayload(String payload) {
    try {
      final duaData = jsonDecode(payload);

      if (navigatorKey.currentState != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => BottomNav(),
          ),
        );
      } else {
        pendingPayload =
            payload; // Store payload if navigation stack is not ready
      }
    } catch (e) {
      print('Error handling notification payload: $e');
      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (contex) => BottomNav()));
    }
  }

  /// Process any pending payload after app is ready
  static void handlePendingPayload() {
    if (pendingPayload != null) {
      _handleNotificationPayload(pendingPayload!);
      pendingPayload = null; // Clear the payload after handling
    }
  }

  static Future<void> dailySchedulNotification(int c) async {
    // Set the desired time for the notification
    const int targetHour = 11; // 11 AM
    const int targetMinute = 0;
    

    // Get the current date and time
    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      targetHour,
      targetMinute,
    );

    // Adjust to the next day if the time has already passed
    final firstNotificationTime = scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;

    // Notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'reminder_channel',
        'Reminder Notification',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    // Convert to timezone-aware time
    final tz.TZDateTime tzFirstNotificationTime =
        tz.TZDateTime.from(firstNotificationTime, tz.local);

    // Payload for notification
    final payload = jsonEncode('payload');
  

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Daily Reminder',
      '$c ${c==1?'task is':'tasks are'}  still pending complete ${c==1?'it':'them'} and take one step closer to your dream.',
      tzFirstNotificationTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  /// Cancel notification
  static Future<void> cancelNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
