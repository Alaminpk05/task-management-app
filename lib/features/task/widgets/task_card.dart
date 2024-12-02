import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/data/model/task_model.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';

Widget buildTaskItem(context, TaskModel task) {
  print(' Text of task');
  print(task.text);
  return Dismissible(
    key: Key(task.id.toString()),
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
                  text: task.text??'Empty',
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
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              onPressed: () {}),
          IconButton(icon: const Icon(Icons.archive_outlined), onPressed: () {})
        ],
      ),
    ),
    onDismissed: (direction) {},
  );
}
