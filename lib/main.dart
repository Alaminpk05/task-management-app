import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/bottom_nav_bar/bloc/navbarchange/bottom_nav_bloc.dart';
import 'package:task_management_app/features/bottom_nav_bar/presentation/page/bottom_nav.dart';
import 'package:task_management_app/utils/objectbox_helper/setup.dart';

import 'features/task/bloc/task_bloc.dart';

late ObjectBox objectbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
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
                create: (context) => TaskBloc(),
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
