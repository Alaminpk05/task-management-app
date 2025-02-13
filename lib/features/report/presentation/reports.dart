import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';

class Reports extends StatelessWidget {
  final double radius = 30.sp;
  final double centerRadius = 25.sp;

  Reports({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Task Report',
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              Stack(
                children: [
                  // Row containing Pie Chart and Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Pie Chart within AspectRatio for equal width and height
                      BlocBuilder<TaskBloc, TaskState>(
                        builder: (context, state) {
                          final done, undone, archive;
                          double? doneCalculation = 0.0,
                              archiveCalculation = 0.0,
                              undoneCalculation = 0.0;
                          if (state.taskList.isNotEmpty) {
                            done = state.taskList
                                .where((task) => task.isComplete == true);
                            undone = state.taskList
                                .where((task) => task.isComplete == false);
                            archive = state.taskList
                                .where((task) => task.isArchive == true);
                            doneCalculation =
                                (done.length / state.taskList.length) * 100;
                            undoneCalculation =
                                (undone.length / state.taskList.length) * 100;
                            archiveCalculation = archive.length == 0.0
                                ? 0
                                : (archive.length / state.taskList.length) *
                                    100;
                          }

                          return SizedBox(
                            height: 30.h,
                            width: 45.w,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: archiveCalculation,
                                    color: Colors.blue,
                                    title: '${archiveCalculation?.toInt()??0.0}%',
                                    radius: radius,
                                    titleStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: undoneCalculation==0?0.1:undoneCalculation,
                                    color: Colors.purple,
                                    title: "${undoneCalculation?.toInt()??0.0}%",
                                    radius: radius,
                                    titleStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: doneCalculation,
                                    color: Colors.green,
                                    title: '${doneCalculation?.toInt()??0.0}%',
                                    radius: radius,
                                    titleStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                centerSpaceRadius: centerRadius,
                                sectionsSpace: 2,
                              ),
                            ),
                          );
                        },
                      ),
                      // Spacing between chart and legend
                      SizedBox(width: 5.w),
                      // Legend (aligned to the right of the pie chart)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Indicator(
                              color: Colors.blue,
                              text: 'Archive Tasks',
                              isSquare: true),
                          SizedBox(height: 1.h),
                          Indicator(
                              color: Colors.purple,
                              text: 'Undone Tasks',
                              isSquare: true),
                          SizedBox(height: 1.h),
                          Indicator(
                              color: Colors.green,
                              text: 'Done Tasks',
                              isSquare: true),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Ensure the row takes minimal space
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
