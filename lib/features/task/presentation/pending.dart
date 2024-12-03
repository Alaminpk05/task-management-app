// Import necessary packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/data/model/task_model.dart';
import 'package:task_management_app/features/task/widgets/task_card.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';
import 'package:task_management_app/utils/constant/text.dart';

class Pending extends StatelessWidget {
  const Pending({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    context.read<TaskBloc>().add(TaskFetchedEvent());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, index),
                SizedBox(height: 2.5.h),
                _buildTaskList(context, index),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(
          text: index >= 0 && index <= taskNames.length 
              ? taskNames[index]
              : 'UnKown',
          fontsize: 19.sp,
          fontwight: FontWeight.bold,
          color: Colors.black,
        ),
        IconButton(
          onPressed: () {
            // Implement archive functionality if needed
          },
          icon: Icon(Icons.archive),
        ),
      ],
    );
  }

  Widget _buildTaskList(BuildContext context, int index) {
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
          }
          else if(index==1){
             pendingTaskList = task.where((task) => task.isComplete==true).toList();
          }
          else {
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
        } else {
          return Center(
            child: Text(
              'No pending tasks.',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
