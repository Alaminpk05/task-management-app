import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/data/model/task_model.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';
import 'package:task_management_app/utils/constant/text.dart';

Widget buildTaskItem(BuildContext context, TaskModel task, String type) {
  return Dismissible(
    key: Key(task.id.toString()),
    onDismissed: (direction) {
      context.read<TaskBloc>().add(DeleteTaskEvent(id: task.id));
      // Optional: Show a confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task "${task.text}" deleted'),
        ),
      );
    },

    direction: DismissDirection.endToStart, // Define swipe direction
    background: Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.red,
      child: Icon(Icons.delete, color: Colors.white),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromRGBO(0, 188, 212, 0.7),
            radius: 27.sp,
            child: Center(
              child: textWidget(
                text: task.time,
                fontsize: 17.sp,
                fontwight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                  text: task.text,
                  fontsize: 16.5.sp,
                  fontwight: FontWeight.w500,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                textWidget(
                  text: task.date,
                  fontsize: 14.sp,
                  fontwight: FontWeight.w500,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          SizedBox(
            width: 1.5.w,
          ),
          IconButton(
              icon: Icon(
                task.isComplete
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: task.isComplete ? Colors.green : Colors.grey,
              ),
              onPressed: () {
                type == archive
                    ? null
                    : {
                        !task.isComplete,
                        context.read<TaskBloc>().add(
                            CompletedOrIncompletedEvent(
                                id: task.id, iscompleted: !task.isComplete))
                      };
              }),
          type == archive
              ? PopupMenuButton(
                  offset: Offset(30, 30),
                  child: Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == delete) {
                    } else if (value == restore) {}
                  },
                  itemBuilder: (contex) {
                    return [
                      PopupMenuItem(value: delete, child: Text('Delete')),
                      PopupMenuItem(value: restore, child: Text('Restore')),
                    ];
                  })
              : IconButton(
                  icon: const Icon(Icons.archive_outlined),
                  onPressed: () {
                    context.read<TaskBloc>().add(ArchiveTaskEvent(id: task.id));
                  })
        ],
      ),
    ),
  );
}
