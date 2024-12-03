part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final TaskModel taskModel;

  CreateTaskEvent({required this.taskModel});
}

class TaskFetchedEvent extends TaskEvent{}
class CompletedOrIncompletedEvent extends TaskEvent {
  final bool iscompleted;
  final int id;

  CompletedOrIncompletedEvent( {required this.id,required this.iscompleted});
}
