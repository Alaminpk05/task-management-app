// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/utils/widgets/pages_widgets/header.dart';
import 'package:task_management_app/utils/widgets/tasks/buildtasklist.dart';

class Pending extends StatelessWidget {
  const Pending({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc()..add(TaskFetchedEvent()),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(context, index),
                  SizedBox(height: 2.5.h),
                  buildTaskList(context, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
