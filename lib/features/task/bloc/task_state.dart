// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState {
  final List<TaskModel> taskList;
  TaskState({
    this.taskList = const <TaskModel>[],
  });
}
