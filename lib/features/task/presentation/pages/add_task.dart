import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/task/bloc/task_bloc.dart';
import 'package:task_management_app/features/task/data/model/task_model.dart';


class AddTaskCard extends StatefulWidget {
  AddTaskCard({
    super.key,
  });

  @override
  State<AddTaskCard> createState() => _AddTaskCardState();
}

class _AddTaskCardState extends State<AddTaskCard> {
  TextEditingController taskController = TextEditingController();
  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                  )
                ],
                color: Colors.white,
              ),
              child: const Icon(
                Icons.note_alt_outlined,
                color: Color.fromARGB(255, 143, 128, 128),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'New task',
                style: TextStyle(
                  fontSize: 23,
                  color: const Color.fromARGB(255, 143, 128, 128),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          height: 9.h,
          child: TextField(
            controller: taskController,
            maxLines: null,
            expands: false,
            style: TextStyle(
              color: const Color.fromARGB(255, 128, 124, 124),
            ),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.sp),
              ),
              filled: false,
              hintText: 'What are you planning?',
              hintStyle: TextStyle(
                color: const Color(0xff9C9A9A),
              ),
            ),
            // controller: textEditingController,
            
            onTapOutside: (event) {},
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: () {
              final date = DateFormat('dd MMMM yyyy').format(DateTime.now());

              final time = DateFormat('hh:mm a').format(DateTime.now());
              final TaskModel task = TaskModel(
                  time: time,
                  text: taskController.text.trim(),
                  date: date,
                  isComplete: false);
              context.read<TaskBloc>().add(CreateTaskEvent(taskModel: task));
              Navigator.pop(context);
            },
            child: Text(
              "Create",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
