import 'package:up_todo_app/feature/home_screen/index/data/data_source/task_data_source.dart';
import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';

import '../../domain/repo/tasks_repo.dart';

class TaskRepoImpl implements TaskRepo {
  TaskDataSource dataSource;

  TaskRepoImpl(this.dataSource);

  @override
  Future<void> addTask(TaskModel model) async {
    await dataSource.addTask(model);
  }

  @override
  Future<void> editTask(TaskModel model) async {
    await dataSource.editTask(model);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return await dataSource.getAllTasks();
  }

  @override
  Future<void> removeTask(String id) async {
    await dataSource.removeTask(id);
  }
}
