import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/bottom_nav_bar/bloc/navbarchange/bottom_nav_bloc.dart';
import 'package:task_management_app/features/bottom_nav_bar/presentation/page/bottom_nav.dart';
import 'package:task_management_app/features/notification/data/notification_services.dart';
import 'package:task_management_app/utils/objectbox_helper/setup.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'features/task/bloc/task_bloc.dart';

late ObjectBox objectbox;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  tz.initializeTimeZones();

  objectbox = await ObjectBox.create();
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((_) {
    NotificationService.handlePendingPayload();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

   @override
  void initState()  {
   
    super.initState();
    // _showNotification();
  }

  // Future<void> _showNotification() async {
  //   await NotificationService.dailySchedulNotification(1);
  // }
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<BottomNavBloc>(
                create: (context) => BottomNavBloc(),
              ),
              BlocProvider<TaskBloc>(
                create: (context) => TaskBloc()..add(NotificationEvent()),
              ),
            ],
            child: MaterialApp(
                title: 'Task Manager',
                theme: ThemeData(
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: Colors.green),
                  appBarTheme: AppBarTheme(color: Colors.green),
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: false,
                ),
                debugShowCheckedModeBanner: false,
                home: const BottomNav()));
      },
    );
  }
}
