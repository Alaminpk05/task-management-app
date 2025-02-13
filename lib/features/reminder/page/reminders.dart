import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';

class Reminders extends StatelessWidget {
  const Reminders({
    super.key,
  });

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
                TextWidget(
                  text: 'Reminders',
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(height: 2.5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
