import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/archive/pesentation/archive.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';
import 'package:task_management_app/utils/constant/text.dart';

Widget buildHeader(BuildContext context, int index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextWidget(
        text: index >= 0 && index <= taskNames.length
            ? taskNames[index]
            : 'UnKown',
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => ArchivePage(index: 4)));
        },
        icon: Icon(Icons.archive),
      ),
    ],
  );
}
