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

class ArchiveTaskDelete extends TaskEvent {
  final int id;

  ArchiveTaskDelete({required this.id});
}

class ArchiveTaskRestore extends TaskEvent {
  final bool isArchive;

  ArchiveTaskRestore({required this.isArchive});
}
