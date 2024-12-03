// Import necessary packages
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
    context.read<TaskBloc>().add(TaskFetchedEvent());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 2.5.h),
                _buildTaskList(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textWidget(
          text: 'Pending Task',
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

  Widget _buildTaskList(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is ErrorState) {
          return Center(
            child: Text('Error: ${state.errorMessege}',
                style: TextStyle(color: Colors.red, fontSize: 14.sp)),
          );
        } else if (state.taskList.isNotEmpty) {
           final task = state.taskList;
          final pendingTaskList = task.where((task) => !task.isComplete).toList();
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
