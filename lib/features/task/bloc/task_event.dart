part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final TaskModel taskModel;

  CreateTaskEvent({required this.taskModel});
}

class TaskFetchedEvent extends TaskEvent {}

class CompletedOrIncompletedEvent extends TaskEvent {
  final bool iscompleted;
  final int id;

  CompletedOrIncompletedEvent({required this.id, required this.iscompleted});
}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  DeleteTaskEvent({required this.id});
}

class ArchiveTaskEvent extends TaskEvent {
  final int id;

  ArchiveTaskEvent({required this.id});
}

class DeleteArchiveAllTask extends TaskEvent {
  final List<TaskModel> archiveTaskList;

  DeleteArchiveAllTask({required this.archiveTaskList});
}

class NotificationEvent extends TaskEvent {
  

  NotificationEvent( );
}
