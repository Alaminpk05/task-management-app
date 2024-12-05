import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/utils/widgets/pages_widgets/header.dart';
import 'package:task_management_app/utils/widgets/tasks/buildtasklist.dart';

class Completed extends StatefulWidget {
  const Completed({super.key, required this.index});
  final int index;

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  void initState() {
    context.read<TaskBloc>().add(TaskFetchedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(context, widget.index),
                SizedBox(height: 2.5.h),
                buildTaskList(context, widget.index),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
