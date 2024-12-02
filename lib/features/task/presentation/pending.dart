import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/widgets/task_card.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';

class Pending extends StatelessWidget {
  const Pending({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      text: 'Pending Task',
                      fontsize: 19.sp,
                      fontwight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.archive))
                  ],
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    final taskList = state.taskList;
                    if (taskList.isNotEmpty) {
                      return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = taskList[index];

                            return buildTaskItem(context, item);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                                height: 2.h, color: Colors.grey[300]);
                          },
                          itemCount: taskList.length);
                    } else {
                      return Center(child: Text('Empty'));
                    }
                    
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
