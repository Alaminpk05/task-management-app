import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';
import 'package:task_management_app/utils/widgets/pages_widgets/header.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key, required this.index});
  final int index;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               textWidget(text:'Reminders',
                fontsize: 19.sp,
                fontwight: FontWeight.bold, color: Colors.black,),
                SizedBox(height: 2.5.h),
                // buildTaskList(context, widget.index,completed),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
