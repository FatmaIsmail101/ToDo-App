import 'package:up_todo_app/feature/home_screen/index/data/model/task_model.dart';
import 'package:up_todo_app/feature/home_screen/index/domain/repo/tasks_repo.dart';

class TaskUseCase {
  TaskRepo repo;

  TaskUseCase(this.repo);

  Future<void> addTaskUseCase(TaskModel model) async {
    await repo.addTask(model);
  }

  Future<void> removeTaskUseCas(String id) async {
    await repo.removeTask(id);
  }

  Future<void> editTaskUseCase(TaskModel model) async {
    await repo.editTask(model);
  }

  Future<List<TaskModel>> getAllTasksUseCas() async {
    return await repo.getAllTasks();
  }

  Future<void> addCategory(Category model) async {
    await repo.addCategory(model);
  }

  Future<List<Category>> getAllCategories() async {
    return await repo.getAllCategories();
  }
}
