import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/data/model/task_model.dart';
import 'package:task_management_app/features/task/presentation/widgets/task_card.dart';

Widget buildTaskList(BuildContext context, int index) {
  return BlocBuilder<TaskBloc, TaskState>(
    builder: (context, state) {
      if (state is ErrorState) {
        return Center(
          child: Text('Error: ${state.errorMessege}',
              style: TextStyle(color: Colors.red, fontSize: 14.sp)),
        );
      } else if (state.taskList.isNotEmpty) {
        final task = state.taskList;
        List<TaskModel> pendingTaskList;
        if (index == 0) {
          pendingTaskList = task.where((task) => !task.isComplete).toList();
        } else if (index == 1) {
          pendingTaskList = task.where((task) => task.isComplete).toList();
        } else {
          return Center(
            child: Text(
              'No tasks available.',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: pendingTaskList.length,
          itemBuilder: (context, index) {
            return buildTaskItem(context, pendingTaskList[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(height: 2.h, color: Colors.grey[300]);
          },
        );
      }
      return SizedBox.shrink();
    },
  );
}
