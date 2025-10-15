import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

abstract class TaskRepo {
  Future<void> addTask(TaskModel model);

  Future<void> editTask(TaskModel model);

  Future<void> removeTask(String id);

  Future<List<TaskModel>> getAllTasks();
}
