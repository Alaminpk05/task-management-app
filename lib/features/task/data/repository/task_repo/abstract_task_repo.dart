import 'package:task_management_app/features/task/data/model/task_model.dart';

abstract class AbstractTaskRepo {
  Future<void> insertTask(TaskModel task);
  Future<List<TaskModel>>fetchedAllTask();
}
