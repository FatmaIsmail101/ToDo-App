import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

abstract class TaskDataSource {
  Future<void> addTask(TaskModel task);

  Future<List<TaskModel>> getAllTasks();

  Future<void> removeTask(String id);

  Future<void> editTask(TaskModel task);
}
