// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/utils/constant/text.dart';
import 'package:task_management_app/utils/widgets/pages_widgets/header.dart';
import 'package:task_management_app/utils/widgets/tasks/buildtasklist.dart';

class Pending extends StatefulWidget {
  const Pending({super.key, required this.index});
  final int index;

  @override
  State<Pending> createState() => _PendingState();
}


class _PendingState extends State<Pending> {
  @override
  void initState() {
     context.read<TaskBloc>().add(TaskFetchedEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
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
                    buildTaskList(context, widget.index,pending),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
