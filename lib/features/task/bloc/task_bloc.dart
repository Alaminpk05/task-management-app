import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:task_management_app/features/task/data/model/task_model.dart';
import 'package:task_management_app/features/task/data/repository/task_repo/task_repo.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepo taskRepo = TaskRepo();
  TaskBloc() : super(TaskState()) {
    on<CreateTaskEvent>(_oncreatetask);
  }

  Future<void> _oncreatetask(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepo.insertTask(event.taskModel);
      final newTasklist = await taskRepo.fetchedAllTask();
      for (int i = 0; i < newTasklist.length; i++) {
        print(newTasklist[i]);
      }
      emit(TaskState(taskList: newTasklist));
    } catch (e) {
      if (kDebugMode) {
        print('Error inserting task: $e');
      }
    }
  }
}
