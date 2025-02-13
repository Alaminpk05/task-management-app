import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';
import 'package:task_management_app/utils/constant/text.dart';

import 'package:task_management_app/utils/widgets/tasks/buildtasklist.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key, required this.index});
  final int index;

  @override
  State<ArchivePage> createState() => _ARchivePageState();
}

class _ARchivePageState extends State<ArchivePage> {
  @override
  void initState() {
    context.read<TaskBloc>().add(TaskFetchedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        final archiveTaskList =
            state.taskList.where((task) => task.isArchive == true).toList();
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
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        TextWidget(
                          text: 'Archive',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        PopupMenuButton(
                            offset: Offset(30, 30),
                            child: Icon(Icons.more_vert),
                            onSelected: (value) {
                              context.read<TaskBloc>().add(DeleteArchiveAllTask(
                                  archiveTaskList: archiveTaskList));

                              debugPrint(
                                  'Clicked on archive header more: ${archiveTaskList.length}');
                            },
                            itemBuilder: (contex) {
                              return [
                                PopupMenuItem(
                                    value: delete, child: Text('Delete All')),
                              ];
                            }),
                      ],
                    ),
                    SizedBox(height: 2.5.h),
                    buildTaskList(context, widget.index, archive),
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
