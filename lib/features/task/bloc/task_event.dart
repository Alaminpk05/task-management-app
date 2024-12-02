part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final TaskModel taskModel;

  CreateTaskEvent({required this.taskModel});
}
