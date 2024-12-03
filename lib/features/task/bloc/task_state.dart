// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_bloc.dart';

class TaskState {
  final List<TaskModel> taskList;
  TaskState({
    this.taskList = const <TaskModel>[],
  });
}

final class ErrorState extends TaskState {
  final String errorMessege;

  ErrorState({super.taskList, required this.errorMessege});
}
