import 'package:task_management_app/features/task/data/model/task_model.dart';
import 'package:task_management_app/features/task/data/repository/task_repo/abstract_task_repo.dart';
import 'package:task_management_app/main.dart';

class TaskRepo implements AbstractTaskRepo {
  final taskBox = objectbox.store.box<TaskModel>();
  @override
  Future<List<TaskModel>> fetchedAllTask() async {
    List<TaskModel> taskList = await taskBox.getAllAsync();

    return taskList;
  }

  @override
  Future<void> insertTask(TaskModel task) async {
    await taskBox.putAsync(task);
  }

  @override
  Future<void> updateTaskStatus(int id, bool isCompleted) async {
    final task = await taskBox.getAsync(id);
    if (task != null) {
      task.isComplete = isCompleted;
      await taskBox.putAsync(task);
    }
  }

  @override
  Future<void> deleteTask(int id) async {
    await taskBox.removeAsync(id);
  }
}
