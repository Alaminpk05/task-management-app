// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path/path.dart';
// import 'package:sizer/sizer.dart';
// import 'package:task_management_app/features/bottom_nav_bar/presentation/page/bottom_nav.dart';
// import 'package:task_management_app/features/task/data/model/task_model.dart';
// import 'package:task_management_app/features/task/presentation/pages/pending.dart';
// import 'package:task_management_app/features/widgets/text_widget.dart';
// import 'package:task_management_app/main.dart';
// import 'package:timezone/timezone.dart' as tz;

// class NotificationServices {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static String? pendingPayload;

//   // Sart initializaion for notification
//   static Future<void> init() async {
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings();

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

//     // HANDLE LAUNCHED THE APP FROM NOTIFICATION
//     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
//       final String? payload =
//           notificationAppLaunchDetails!.notificationResponse?.payload;
//       if (payload != null) {
//         pendingPayload = payload;
//       }
//     }
//     // Request permission for notifications (Android)
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestNotificationsPermission();

//     // // Request permission for notifications (iOS)
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//   } //END OF INITIALIZATION

//   // Notification Response Handled
//   static Future<void> onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final payload = notificationResponse.payload;

//     if (payload != null) {
//       try {
//         final data = jsonDecode(payload);
//         final task = TaskModel.fromJson(data);
//         if (navigatorKey.currentState != null) {
//           navigatorKey.currentState
//               ?.push(MaterialPageRoute(builder: (c) => BottomNav()));
//         } else {
//           pendingPayload = payload;
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
//             content: Text(
//                 'The bug has woken up from sleep. It needs some code to go to sleep again.')));
//       }
//     }
//   } //Done setup

//   static Future<void> dailySchedulNotification(TimeOfDay timeOfDay) async {
//     // Initialize with the first item or a default value

//     final now = DateTime.now();
//     final scheduledDate = DateTime(
//         now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

//     final firstNotificationTime = scheduledDate.isBefore(now)
//         ? scheduledDate.add(Duration(days: 1))
//         : scheduledDate;

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'reminder_channel',
//         'Reminder Notification',
//         importance: Importance.high,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );

//     final tz.TZDateTime tzFirstNotificationTime =
//         tz.TZDateTime.from(firstNotificationTime, tz.local);
//     final payload = 'payload';
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'title',
//       'body',
//       tzFirstNotificationTime,
//       platformChannelSpecifics,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       payload: payload,
//       matchDateTimeComponents: DateTimeComponents.time,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     );
//   }

//   /// Cancel notification
//   static Future<void> cancelNotification() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
