import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:task_management_app/features/notification/data/notification_services.dart';
import 'package:task_management_app/features/task/data/model/task_model.dart';
import 'package:task_management_app/features/task/data/repository/task_repo/task_repo.dart';
part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepo taskRepo = TaskRepo();
  TaskBloc() : super(TaskState()) {
    on<TaskFetchedEvent>(_ontaskFetchedEvent);
    on<CreateTaskEvent>(_oncreatetask);
    on<CompletedOrIncompletedEvent>(_oniscompleted);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
    on<ArchiveTaskEvent>(_onArchiveTask);
    on<DeleteArchiveAllTask>(_onDeleteArchiveAllTask);
    on<NotificationEvent>(_onNotificationEvent);
  }
  Future<void> _ontaskFetchedEvent(
      TaskFetchedEvent event, Emitter<TaskState> emit) async {
    try {
      final updatedList = await taskRepo.fetchedAllTask();
      final c = await taskRepo.pendingTaskCounter(updatedList);
      if (c == 0) {
        await NotificationService.cancelNotification(0);
      }
      else{
        await NotificationService.dailySchedulNotification(c);
      }
      
      emit(TaskState(taskList: updatedList));
    } catch (e) {
      emit(ErrorState(errorMessege: e.toString()));
    }
  }

  Future<void> _oncreatetask(
      CreateTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepo.insertTask(event.taskModel);
      final updatedList = await taskRepo.fetchedAllTask();
      final c = await taskRepo.pendingTaskCounter(updatedList);
      if (c == 0) {
        await NotificationService.cancelNotification(0);
      }
      else{
        await NotificationService.dailySchedulNotification(c);
      }

      emit(TaskState(taskList: updatedList));
    } catch (e) {
      if (kDebugMode) {
        emit(ErrorState(errorMessege: e.toString()));
      }
    }
  }

  Future<void> _oniscompleted(
      CompletedOrIncompletedEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepo.updateTaskStatus(event.id, event.iscompleted);
      final updatedList = await taskRepo.fetchedAllTask();
      final c = await taskRepo.pendingTaskCounter(updatedList);
      if (c == 0) {
        await NotificationService.cancelNotification(0);
      }
      else{
        await NotificationService.dailySchedulNotification(c);
      }
      emit(TaskState(taskList: updatedList));
    } catch (e) {
      emit(ErrorState(errorMessege: e.toString()));
    }
  }

  FutureOr<void> _onDeleteTaskEvent(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepo.deleteTask(event.id);
      final updatedList = await taskRepo.fetchedAllTask();
      final c = await taskRepo.pendingTaskCounter(updatedList);
      if (c == 0) {
        await NotificationService.cancelNotification(0);
      }
      else{
        await NotificationService.dailySchedulNotification(c);
      }
      emit(TaskState(taskList: updatedList));
    } catch (e) {
      emit(ErrorState(errorMessege: e.toString()));
    }
  }

  Future<void> _onArchiveTask(
      ArchiveTaskEvent event, Emitter<TaskState> emit) async {
    try {
      await taskRepo.archiveTask(event.id);
      final updatedList = await taskRepo.fetchedAllTask();
      final c = await taskRepo.pendingTaskCounter(updatedList);
      if (c == 0) {
        await NotificationService.cancelNotification(0);
      }
      else{
        await NotificationService.dailySchedulNotification(c);
      }
      emit(TaskState(taskList: updatedList));
    } catch (e) {
      emit(ErrorState(errorMessege: e.toString()));
    }
  }

  Future<void> _onDeleteArchiveAllTask(
      DeleteArchiveAllTask event, Emitter<TaskState> emit) async {
    try {
      await taskRepo.deleteArchiveAllTask(event.archiveTaskList);
      final updatedList = await taskRepo.fetchedAllTask();
      final c = await taskRepo.pendingTaskCounter(updatedList);
      if (c == 0) {
        await NotificationService.cancelNotification(0);
      }
      else{
        await NotificationService.dailySchedulNotification(c);
      }
      emit(TaskState(taskList: updatedList));
    } catch (e) {
      emit(ErrorState(errorMessege: e.toString()));
    }
  }

  Future<void> _onNotificationEvent(
      NotificationEvent event, Emitter<TaskState> emit) async {
    try {
      final c = await taskRepo.pendingTaskCounter(state.taskList);
      if (c == 0) {
        await NotificationService.cancelNotification(0);
      }
      else{
        await NotificationService.dailySchedulNotification(c);
      }
    } catch (e) {
      emit(ErrorState(errorMessege: e.toString()));
    }
  }
}
